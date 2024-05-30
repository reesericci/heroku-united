namespace :migrate do
  namespace 0.to_s.to_sym do
    desc "Migrate to v0.2"
    task 2.to_s.to_sym => [:environment] do
      begin
        sh "which openssl"
      rescue
        raise "


        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!                                    !!
        !!  This script *requires* OpenSSL!   !!
        !!                                    !!
        !!  Can't install? Fear not!          !!
        !!                                    !!
        !!  You can still upgrade manually,   !!
        !!  just file an issue at:            !!
        !!                                    !!
        !!  codeberg.org/reesericci/united    !!
        !!                                    !!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


        "
      end
      sh "bin/rails db:migrate"
      @dir = pwd
      cd "/tmp"
      sh "openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:2048"
      sh "cat private_key.pem"
      puts "
#########################################

Copy the above key to your clipboard,
then paste it into the Rails credentials
like this:
```
oidc:
  key: |
    [key content here, indented properly]
```

Press any key to continue once copied
      "
      $stdin.getch

      sh "rm private_key.pem"
      cd @dir
      sh "bin/rails credentials:edit"

      puts "
##########################################

United now needs to know the external URL
of this instance, protocol included.

Please enter it and then push [ENTER]

"
      external = $stdin.gets.chomp

      Config.first.update!(external_url: external)

      puts "
###########################################

Success! United is now prepared for v0.2.0

Thank you for using United to manage your
organization's membership.

--reese
      "
    end
  end
end
