.PHONY: init create-db load-initial-data init-app install-dependencies run

DEFAULT_GOAL := run

PROJECT_NAME = trec_nitc

init:
	@$(MAKE) install-dependencies
	@$(MAKE) drush-make
	@$(MAKE) create-db
	@$(MAKE) init-app
	@$(MAKE) load-initial-data

install-dependencies:
ifeq ($(shell which drush),)
	@echo "Installing Drush..."
	pear install drush/drush
else
	@echo "Rad, Drush is already installed"
endif
ifeq ($(shell which sass),)
	@echo "Installing Sass..."
	gem install sass
else
	@echo "Rad, Sass is already installed"
endif
ifeq ($(shell which compass),)
	@echo "Installing Compass..."
	gem install compass
else
	@echo "Rad, Compass is already installed"
endif

drush-make:
	@echo "running the drush make file: trec.make..."
	@echo "You gonna need an ssh key for the OIT_ARC githubs for to get all your repos, pal"
	cd /home; sudo mkdir trec_nitc;
	cd /home/trec_nitc && drush make --working-copy ./trec.make /home/trec_nitc/htdocs

create-db:
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $(PROJECT_NAME);"
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS ppms"

init-app:
	mv /home/trec_nitc/htdocs/sites/all/modules/custom/otrec-cms/otrec_profile/ ./htdocs/profiles/otrec
	cp ./trec_dev_settings.php /home/trec_nitc/htdocs/sites/default/settings.php
	touch ./htdocs/sites/all/modules/custom/otrec-cms/ppms/ppms_settings.php
	cd /home/trec_nitc/htdocs; drush si otrec;
	cp ./trec_local.conf /etc/httpd/vhost.d/
	service httpd reload
	cd /home/trec_nitc/htdocs/sites/all/themes/psu_research_theme && compass compile;
	cd /home/trec_nitc/htdocs/sites/all/themes/otrec_subtheme && compass compile;
	cd /home/trec_nitc/htdocs/sites/all/themes/nitc_subtheme && compass compile;


load-initial-data:
	@echo "Not loading intial data cuase I ain't got none yet."
	@echo "Rad. You can change your local dev settings in htdocs/sites/default/settings.php"
# Requires PHP >= 5.4
run:
	php -S localhost:8000
