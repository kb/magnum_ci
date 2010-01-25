Build.blueprint do
  log       { Faker::Lorem.paragraphs(3).join("\n\n") }
  passed    { true }
end