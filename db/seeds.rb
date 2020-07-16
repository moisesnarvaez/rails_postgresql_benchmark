
def random_business_types
  max = rand(3..5)
  generated_types = (1..max).map{ Faker::Company.unique.industry }
  Faker::Company.unique.clear
  generated_types
end

def random_attributes(generated_types=nil)
  {
    name: Faker::Company.name,
    business_types_jsonb: generated_types || random_business_types
  }
end

# ------------------------------------------------------------------------------
total_records = 100_000
block_size = 1000

(1..total_records).each_slice(block_size) do |batch|
  batch.each do |i|
    generated_types = random_business_types
    business = Business.create!(random_attributes(generated_types))
    business.business_types_jsonb.each do |type|
      business.business_types.create!(label: type)
    end
    p "# #{i} created"
  end
end
