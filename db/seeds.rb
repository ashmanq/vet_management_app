require_relative( "../models/animal.rb" )
require_relative( "../models/vet.rb" )
require_relative( "../models/owner.rb" )
require("pry-byebug")

Vet.delete_all()
Animal.delete_all()
Owner.delete_all()

vet1 = Vet.new('first_name' => "James", 'last_name' => "Sullivan")
vet1.save()

vet2 = Vet.new('first_name' => "Elon", 'last_name' => "Musk")
vet2.save()

vet3 = Vet.new('first_name' => "Marolyn", 'last_name' => "Munro")
vet3.save()

owner1 = Owner.new('first_name' => 'James', 'last_name' => 'Khan',
                    'address' => '123 Rd, G1 3ED', 'tel_no' => '0141 123456')
owner1.save()

owner2 = Owner.new('first_name' => 'Theresa', 'last_name' => 'May',
                    'address' => '1 Posh Place, L1 1AA', 'tel_no' => '0141 000000')
owner2.save()

owner3 = Owner.new('first_name' => 'Greta', 'last_name' => 'Thurnberg',
                    'address' => '1 A road, GG1 1AA', 'tel_no' => '01 66 000000')
owner3.save()

animal1 = Animal.new('name' => "Raja", 'type' => "cat", 'dob' => "01/01/18",
               'owner_id' => owner1.id, 'treatment_notes' => "Suffering from cat flu",
               'vet_id' => vet1.id)
animal1.save()

animal2 = Animal.new('name' => "Rocko", 'type' => "doggo", 'dob' => "03/06/16",
               'owner_id' => owner2.id, 'treatment_notes' => "Broken Leg",
               'vet_id' => vet2.id)
animal2.save()

animal2 = Animal.new('name' => "Buster", 'type' => "Rabbit", 'dob' => "03/06/00",
               'owner_id' => owner2.id, 'treatment_notes' => "Drinking problem",
               'vet_id' => vet3.id)
animal2.save()

animal2 = Animal.new('name' => "Big bird", 'type' => "Bird", 'dob' => "03/07/00",
               'owner_id' => owner2.id, 'treatment_notes' => "Drinking problem",
               'vet_id' => vet3.id)
animal2.save()

binding.pry
nil
