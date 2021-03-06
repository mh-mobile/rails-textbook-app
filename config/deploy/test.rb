 # frozen_string_literal: true

 server "160.16.113.203",
   user: "deploy",
   roles: %w{web app db},
   ssh_options: {
     port: 54321,
     keys: %w(~/.ssh/deploy_rsa),
     forward_agent: true,
     auth_methods: %w(publickey)
   }
