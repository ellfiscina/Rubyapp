namespace :utils do

  desc "Setup development"
  task setup_dev: :environment do
    puts "Executando..."

    %x(rake db:drop)
    %x(rake db:create)
    %x(rake db:migrate)
    %x(rake db:seed)
    %x(rake utils:generate_admins)
    %x(rake utils:generate_members)
    %x(rake utils:generate_ads)

    puts "[OK]"
  end

  ############################################################################

  desc "Cria Administradores Fake"
  task generate_admins: :environment do
    puts "Cadastrando ADMINISTRADORES..."

    10.times do
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456",
        role: [0,0,1,1,1].sample
      )
    end

    puts "[OK]"
  end

  ############################################################################

  desc "Cria Membros Fake"
  task generate_members: :environment do
    puts "Cadastrando MEMBROS..."

    100.times do
      Member.create!(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
    end

    puts "[OK]"
  end

  ############################################################################

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando ANUNCIOS..."

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-adds', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    puts "[OK]"
  end


end
