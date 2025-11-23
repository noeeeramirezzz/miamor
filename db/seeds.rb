# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Cargo.create([
               { nombre: "Decorador", salario: 450000 },
               { nombre: "Mozo", salario: 400000 },
               { nombre: "DJ", salario: 650000 },
               { nombre: "Tecnico de Iluminación", salario: 200000 },
               { nombre: "Animador Infantil", salario: 300000 },
               { nombre: "Fotógrafo", salario: 200000}
             ])
