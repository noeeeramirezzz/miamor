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


               { nombre: "Decorador Principal", salario: 600000 },
               { nombre: "Ambientador", salario: 350000 },
               { nombre: "Auxiliar de decoracion", salario: 250000 },
               { nombre: "Asistente de Producción", salario: 300000 },
               { nombre: "Tecnico de Iluminación", salario: 300000 },
               { nombre: "DJ", salario: 600000 },
               { nombre: "Sonidista", salario: 650000 },
               { nombre: "Operador Técnico", salario: 350000 },
               { nombre: "Fotógrafo", salario: 500000 },
               { nombre: "Mozo", salario: 180000 },
               { nombre: "Bartender", salario: 220000 },
               { nombre: "Recepcionista", salario: 250000 },
               { nombre: "Animador", salario: 400000 },
               { nombre: "Payaso", salario: 200000 }
             ])

Servicio.create([
                  { nombre: "Decoración general del evento", categoria: "Decoración", costo_base: 800000 },
                  { nombre: "Decoración temática", categoria: "Decoración", costo_base: 1200000 },
                  { nombre: "Centros de mesa", categoria: "Decoración", costo_base: 300000 },

                  { nombre: "Iluminación ambiental", categoria: "Luces", costo_base: 500000 },
                  { nombre: "Dj Set", categoria: "Sonido", costo_base: 800000 },
                  { nombre: "Sonido para ambiente", categoria: "Sonido", costo_base: 600000 },
                  { nombre: "Parlantes - consolas - monitores", categoria: "Sonido", costo_base: 700000 },

                  { nombre: "Fotografía del evento", categoria: "Fotografías", costo_base: 1500000 },

                  { nombre: "Atención en mesas", categoria: "Servicio de Atención", costo_base: 100000 },
                  { nombre: "Servicios de bebidas", categoria: "Servicio de Atención", costo_base: 120000 },
                  { nombre: "Anfitrión / Recepcionista", categoria: "Servicio de Atención", costo_base: 250000 },

                  { nombre: "Animador del evento", categoria: "Animación", costo_base: 400000 },
                  { nombre: "Animador infantil", categoria: "Animación", costo_base: 300000 }
                ])
