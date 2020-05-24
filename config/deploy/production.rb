 # frozen_string_literal: true

 server "160.16.113.203",
   user: "deploy",
   roles: %w{web app db},
   ssh_options: {
     port: 54321,
     keys: %w(~/.ssh/id_rsa_d221d18afc86adcb1fe3331f5350bb88),
     forward_agent: true,
     auth_methods: %w(publickey)
   }
