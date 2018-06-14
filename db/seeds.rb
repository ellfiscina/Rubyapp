# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cadastrando as categorias"

categories = [ "Animais e acessórios" ,
                "Esportes" ,
                "Para a sua casa" ,
                "Eletrônicos e celulares" ,
                "Música e hobbies" ,
                "Bebês e crianças" ,
                "Moda e beleza" ,
                "Veículos e barcos" ,
                "Imóveis" ,
                "Empregos e negócios" ]

# Cria as categorias para popular o db
# Se já existir, não repete (find_or_create_by)
categories.each do |category|
  Category.friendly.find_or_create_by(description: category)
end

puts "[OK]"


puts "Cadastrando o ADMINISTRADOR Padrão..."

Admin.create!(
  name: "Admin Padrão",
  email: "admin@admin.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0
)

puts "[OK]"


puts "Cadastrando o MEMBRO Padrão..."

Member.create!(
  email: "membro@membro.com",
  password: "123456",
  password_confirmation: "123456",
)

puts "[OK]"