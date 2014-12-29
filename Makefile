.PHONY: init create-db load-initial-data init-app install-dependencies run be-done

DEFAULT_GOAL := run

PROJECT_NAME = trec_nitc

init:
	@$(MAKE) install-dependencies
	@$(MAKE) drush-make
	@$(MAKE) create-db
	@$(MAKE) init-app
	@$(MAKE) load-initial-data
	@$(MAKE) be-done 

install-dependencies:
	@echo "*** This script will install dependencies and create a local trec/drupal install as well as a "
# this could be done in a pretty loop	
ifeq ($(shell which drush),)
	@echo "** Installing Drush..."
	pear install drush/drush
else
	@echo "** Rad, Drush is already installed"
endif
ifeq ($(shell which ruby),)
	@echo "** Installing Ruby..."
	yum install ruby ruby-devel
else
	@echo "** Rad, Ruby is already installed"
endif
ifeq ($(shell which gem),)
	@echo "** Installing Rubygems..."
	yum install rubygems
else
	@echo "** Rad, ruby gems is already installed"
endif

ifeq ($(shell which sass),)
	@echo "** Installing Sass..."
	gem install sass
else
	@echo "** Rad, Sass is already installed"
endif
ifeq ($(shell which compass),)
	@echo "** Installing Compass..."
	gem install compass
else
	@echo "Rad, Compass is already installed"
endif

drush-make:
	@echo "*** You gonna need an ssh key for the OIT_ARC githubs for to get all your repos, pal"
	cd /home; sudo mkdir trec_nitc;
	cp ./trec.make /home/trec_nitc
	cd /home/trec_nitc && drush make --working-copy ./trec.make /home/trec_nitc/htdocs
	rm /home/trec_nitc/trec.make

create-db:
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $(PROJECT_NAME);"
	mysql -u root -e "GRANT USAGE ON $(PROJECT_NAME).* to 'trec_l'@'localhost'; DROP USER 'trec_l'@'localhost';"
	mysql -u root -e "CREATE USER 'trec_l'@'localhost';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $(PROJECT_NAME).* TO 'trec_l'@'localhost';"
	mysql -u root -e "DROP DATABASE IF EXISTS ppms_for_drupal"
	mysql -u root -e "CREATE DATABASE ppms_for_drupal"
	mysql -u root -e "GRANT ALL PRIVILEGES ON ppms_for_drupal.* TO 'trec_l'@'localhost'; FLUSH PRIVILEGES; "
	mysql -u root ppms_for_drupal < ./ppms_schema.sql

init-app:
	mv /home/trec_nitc/htdocs/sites/all/modules/custom/otrec-cms/otrec_profile/ /home/trec_nitc/htdocs/profiles/otrec
	cp ./trec_dev_settings.php /home/trec_nitc/htdocs/sites/default/settings.php
	cp ./ppms_dev_settings.php /home/trec_nitc/htdocs/sites/all/modules/custom/otrec-cms/ppms/ppms_settings.php
	cd /home/trec_nitc/htdocs; drush si otrec;
	cp ./trec_nitc.conf /etc/httpd/vhost.d
	service httpd reload
	cd /home/trec_nitc/htdocs/sites/all/themes/psu_research_theme && compass compile;
	cd /home/trec_nitc/htdocs/sites/all/themes/otrec_subtheme && compass compile;
	cd /home/trec_nitc/htdocs/sites/all/themes/nitc_subtheme && compass compile;
	cd /home/trec_nitc/htdocs/sites/all/modules/custom/otrec-cms/ppms/theme && compass compile;


load-initial-data:
	mysql -u root ppms_for_drupal < ./ppms_initial_data.sql
	cd /home/trec_nitc/htdocs; drush en devel_generate -y; drush cache-clear drush;	
	cd /home/trec_nitc/htdocs; drush genc 5 --types=otrec_page;  drush genc 5 --types=otrec_pd_event; drush genc 5 --types=arc_events;
	cd /home/trec_nitc/htdocs; drush genc 5 --types=arc_news; drush genc 5 --types=otrec_in_the_news; drush genc 5 --types=otrec_in_the_news;drush genc 5 --types=otrec_conference;

# Requires PHP >= 5.4
run:
	php -S localhost:8000

be-done:
	@echo "** Rad. a local copy of TREC?NITC is now at /home/trec_nitc/htdocs. a"
