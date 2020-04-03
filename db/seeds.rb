require_relative( "../models/animal.rb" )
require_relative( "../models/vet.rb" )
require_relative( "../models/owner.rb" )
require("pry-byebug")

Vet.delete_all()
Animal.delete_all()
Owner.delete_all()

vet1 = Vet.new('first_name' => "James", 'last_name' => "Sullivan")
vet1.save()

owner1 = Owner.new('first_name' => 'James', 'last_name' => 'Khan',
                    'address' => '123 Rd, G1 3ED', 'tel_no' => '0141 123456')
owner1.save()

animal1 = Animal.new('name' => "Raja", 'type' => "cat", 'dob' => "01/01/18",
               'owner_id' => owner1.id, 'treatment_notes' => "Suffering from cat flu",
               'vet_id' => vet1.id,)
animal1.save()

# vet1 = Vet.new('first_name' => "James", 'last_name' => "Sullivan")
# vet1.save()
# vet2 = Vet.new('first_name' => "Elon", 'last_name' => "Musk")
# vet2.save()
# vet3 = Vet.new('first_name' => "Buzz", 'last_name' => "Lightyear")
# vet3.save()
#
#
#
# animal1 = Animal.new('name' => "Raja", 'type' => "cat", 'dob' => "01/01/18",
#                'owner_name' => "James Khan", 'owner_address' => "122 Something Road, G1 2LR",
#                'treatment_notes' => "Suffering from cat flu", 'vet_id' => vet1.id,
#                 'owner_tel_no' => "01698 123456")
# animal1.save()
#
# animal2 = Animal.new('name' => "Snowy", 'type' => "dog", 'dob' => "05/03/16", 'owner_name' => "Tin Tin",
#                 'owner_address' => "99 Other Road, G1 2LR", 'treatment_notes' => "Fur is too white",
#                 'vet_id' => vet2.id, 'owner_tel_no' => "01698 999999")
# animal2.save()
#
# animal3 = Animal.new('name' => "Toby", 'type' => "Turtle", 'dob' => "06/10/00",
#                'owner_name' => "Surf Dude", 'owner_address' => "10 James Street, SW19 2DD",
#                'treatment_notes' => "Shell needs a scrub", 'vet_id' => vet3.id,
#                'owner_tel_no' => "01698 987654")
# animal3.save()


binding.pry
nil
