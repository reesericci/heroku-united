namespace :migrate do
  namespace 0.to_s.to_sym do
    desc "Migrate to v0.2"
    task 2.to_s.to_sym => [:environment] do
      sh "bin/rails db:migrate"
      @dir = pwd
      puts "
##########################################

United now needs to know the external URL
of this instance, protocol included.

Please enter it and then push [ENTER]

"
      external = $stdin.gets.chomp

      Config.first.update!(external_url: external)

      Member.establish_connection

      Member.all.find_each { |m| m.create_imprint! }

      puts "
###########################################

Success! United is now prepared for v0.2.x

Thank you for using United to manage your
organization's membership.

--reese
      "
    end
  end
end
