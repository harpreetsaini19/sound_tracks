FactoryGirl.define do

  factory :search do
    artist_name "Rihana"
    user_id 1

    trait :second do
      artist_name "Cher"
    end

    trait :third do
      artist_name "Amrinder Gill"
    end

    trait :fourth do
      artist_name "Eminem"
    end

    trait :fifth do
      artist_name "Diljit"
    end

    trait :sixth do
      artist_name "random qwerty"
    end
    
  end
end
