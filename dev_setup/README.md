###README.md

##Dev Box Setup using Vagrant

After bringing up the vagrant box with the given configuration in the Vagrantfile.

You need to do some simple setup to ensure its working.

Go to synced folder

    cd /vagrant_data/

Install the bundler gem

    gem install bundle

Need to do this _hack_ to specify the pgconfig

    bundle config build.pg --with-pg-config=/usr/pgsql-9.6/bin/pg_config

Install all the gems 

    bundle install

Do migration and seed the values

    rake db:migrate
    
    rake db:seed