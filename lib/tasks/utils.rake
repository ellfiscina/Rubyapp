require 'faker'

namespace :utils do
  desc "Cria admin fake"
  task generate_admins: :environment do

    puts "Cadastrando admin fake..."

    10.times do
    Admin.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      password_confirmation: "123456",
      role: [0,1,1].sample
    )
    end

    puts "[OK]"

  end

end
