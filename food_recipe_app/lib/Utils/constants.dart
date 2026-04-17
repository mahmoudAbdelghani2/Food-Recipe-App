import 'package:cooking_app/Models/recipe_model.dart';

class AppConstants {
  static const String appName = "Food Recipe App";
  static List<RecipeModel> allRecipes = [
    RecipeModel(
      id: 1,
      title: "Classic Beef Wellington",
      chefName: "Gordon Ramsay",
      chefCountry: "United Kingdom",
      recipeCountry: "United Kingdom",
      description:
          "A classic centerpiece roast where tender beef is wrapped with mushroom duxelles, prosciutto, and flaky pastry.",
      recipeProcedure: [
        "Season the beef well with salt and pepper, then sear in a very hot pan until browned on all sides.",
        "Brush the warm beef with mustard and let it cool.",
        "Cook finely chopped mushrooms with thyme and garlic until dry and concentrated.",
        "Lay prosciutto on plastic wrap, spread mushroom mixture, then roll the beef tightly inside and chill.",
        "Wrap the chilled roll in puff pastry, seal the edges, and brush with egg wash.",
        "Score lightly and bake at 200C until golden and cooked to your preferred doneness.",
        "Rest before slicing to keep the center juicy.",
      ],
      recipeImageUrl_1:
          "https://as2.ftcdn.net/v2/jpg/03/08/40/41/1000_F_308404151_AKfZDmP5gyA5kd1j8dpgI3pkCbbqQMQR.jpg",
      recipeImageUrl_2:
          "https://miro.medium.com/v2/resize:fit:1100/format:webp/1*hZ7Qf44gByCY246rC72buw.jpeg",
      recipeRating: 4.9,
      time: 120.0,
      calories: 760,
      servings: "2-3",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Beef Tenderloin", amount: 1.0, unit: "kg"),
        Ingredient(name: "Mushrooms", amount: 500.0, unit: "g"),
        Ingredient(name: "Prosciutto Slices", amount: 8.0, unit: "pieces"),
        Ingredient(name: "Puff Pastry", amount: 1.0, unit: "sheet"),
      ],
    ),
    RecipeModel(
      id: 2,
      title: "Authentic Spaghetti Carbonara",
      chefName: "Massimo Bottura",
      chefCountry: "Italy",
      recipeCountry: "Italy",
      description:
          "A Roman pasta icon made with eggs, pecorino, pepper, and guanciale for a rich silky sauce without cream.",
      recipeProcedure: [
        "Boil salted water and cook spaghetti until al dente.",
        "Whisk egg yolks with grated Pecorino Romano and black pepper in a bowl.",
        "Cook guanciale slowly in a pan until crisp and the fat renders.",
        "Move the pan off heat and add drained pasta to coat with guanciale fat.",
        "Add egg-cheese mixture and toss quickly with a splash of pasta water.",
        "Adjust texture until creamy and glossy, then serve immediately.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/056/615/020/non_2x/spaghetti-carbonara-top-view-isolate-on-transparent-background-png.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/16/80/22/81/360_F_1680228193_2PLSqk9WOXuYUSIUsaH3OFkOsyUV3Wun.jpg",
      recipeRating: 4.8,
      time: 25.0,
      calories: 680,
      servings: "1-2",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Spaghetti", amount: 400.0, unit: "g"),
        Ingredient(name: "Guanciale", amount: 150.0, unit: "g"),
        Ingredient(name: "Pecorino Romano", amount: 100.0, unit: "g"),
        Ingredient(name: "Egg Yolks", amount: 4.0, unit: "large"),
      ],
    ),
    RecipeModel(
      id: 3,
      title: "Traditional Butter Chicken (Murgh Makhani)",
      chefName: "Vikas Khanna",
      chefCountry: "India",
      recipeCountry: "India",
      description:
          "A creamy North Indian curry with charred marinated chicken simmered in a buttery tomato sauce.",
      recipeProcedure: [
        "Marinate chicken with yogurt, ginger-garlic paste, lemon juice, and warm spices for several hours.",
        "Roast or grill the chicken until slightly charred but not fully dry.",
        "Cook tomatoes with garlic and whole spices until very soft.",
        "Blend and strain the tomato base for a smooth gravy.",
        "Simmer the sauce with butter and kasoori methi until thick and aromatic.",
        "Add chicken and finish with cream, then simmer briefly before serving.",
      ],
      recipeImageUrl_1:
          "https://masalaandchai.com/wp-content/uploads/2022/03/Butter-Chicken-500x375.jpg",
      recipeImageUrl_2:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480/img/recipe/ras/Assets/89d5040a3e50962bd1fd9acc10c56347/Derivates/feec59de260737f0f037c6f0af6a4068482c9b76.jpg",
      recipeRating: 5.0,
      time: 65.0,
      calories: 520,
      servings: "2-3",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Boneless Chicken", amount: 800.0, unit: "g"),
        Ingredient(name: "Fresh Tomatoes", amount: 6.0, unit: "large"),
        Ingredient(name: "Heavy Cream", amount: 100.0, unit: "ml"),
        Ingredient(name: "Butter", amount: 3.0, unit: "tbsp"),
      ],
    ),
    RecipeModel(
      id: 4,
      title: "Classic French Ratatouille",
      chefName: "Thomas Keller",
      chefCountry: "United States",
      recipeCountry: "France",
      description:
          "A rustic French vegetable bake layered in colorful slices over a rich tomato-pepper base.",
      recipeProcedure: [
        "Cook onion, garlic, and bell pepper in olive oil until soft.",
        "Add crushed tomatoes and herbs to create a thick piperade sauce.",
        "Spread the sauce in the bottom of a baking dish.",
        "Slice zucchini, squash, eggplant, and tomatoes very thinly.",
        "Arrange slices in a tight overlapping pattern, season, and drizzle with olive oil.",
        "Cover with parchment and bake low and slow until vegetables are tender.",
      ],
      recipeImageUrl_1:
          "https://png.pngtree.com/png-clipart/20240325/original/pngtree-ratatouille-french-food-png-image_14674078.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/04/51/46/05/360_F_451460502_Vkvu7sif3k0nCkGgkkcLJ0mQWDGvRq0x.jpg",
      recipeRating: 4.7,
      time: 110.0,
      calories: 210,
      servings: "2-3",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Zucchini", amount: 2.0, unit: "medium"),
        Ingredient(name: "Eggplant", amount: 1.0, unit: "large"),
        Ingredient(name: "Roma Tomatoes", amount: 5.0, unit: "pieces"),
        Ingredient(name: "Crushed Tomatoes", amount: 1.0, unit: "cup"),
      ],
    ),
    RecipeModel(
      id: 5,
      title: "Authentic Tacos al Pastor",
      chefName: "Enrique Olvera",
      chefCountry: "Mexico",
      recipeCountry: "Mexico",
      description:
          "Mexico City street-food favorite: achiote-marinated pork, pineapple, cilantro, and onion in warm tortillas.",
      recipeProcedure: [
        "Blend dried chilies, achiote, garlic, oregano, cumin, vinegar, and pineapple juice into an adobo.",
        "Coat sliced pork shoulder in the marinade and refrigerate overnight.",
        "Roast stacked pork until tender, then slice thinly.",
        "Crisp the slices in a hot pan for caramelized edges.",
        "Warm corn tortillas and prepare chopped onion, cilantro, and pineapple.",
        "Assemble tacos and finish with lime.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/057/174/788/non_2x/deliciously-crafted-tacos-al-pastor-on-a-transparent-plate-garnished-with-lime-and-fresh-cilantro-top-view-delicious-tacos-al-pastor-food-plate-on-a-transparent-background-free-png.png",
      recipeImageUrl_2:
          "https://static.vecteezy.com/system/resources/previews/029/249/722/non_2x/top-view-delicious-tacos-al-pastor-food-plate-on-a-transparent-background-ai-generated-png.png",
      recipeRating: 4.9,
      time: 240.0,
      calories: 610,
      servings: "2-3",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Pork Shoulder", amount: 1.0, unit: "kg"),
        Ingredient(name: "Achiote Paste", amount: 50.0, unit: "g"),
        Ingredient(name: "Fresh Pineapple", amount: 1.0, unit: "cup"),
        Ingredient(name: "Corn Tortillas", amount: 12.0, unit: "pieces"),
      ],
    ),
    RecipeModel(
      id: 6,
      title: "Edomae Sushi - Tuna Nigiri",
      chefName: "Jiro Ono",
      chefCountry: "Japan",
      recipeCountry: "Japan",
      description:
          "Minimalist Japanese sushi pairing seasoned rice with premium tuna and precise hand shaping.",
      recipeProcedure: [
        "Rinse sushi rice until clear, then cook and season with vinegar, sugar, and salt.",
        "Cool the rice to body temperature while keeping it moist.",
        "Slice sashimi-grade tuna into neat rectangular pieces.",
        "Wet your hands with vinegared water and shape small oval rice portions.",
        "Place a touch of wasabi between fish and rice.",
        "Press gently to form nigiri and serve immediately.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/054/720/739/non_2x/delicious-tuna-sushi-nigiri-on-transparent-background-png.png",
      recipeImageUrl_2:
          "https://i.ytimg.com/vi/BoNwXGkRRLw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDjfD7RXtwlgZZnd6HVCDs_sOCSlQ",
      recipeRating: 5.0,
      time: 60.0,
      calories: 330,
      servings: "1-2",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Sushi Rice", amount: 2.0, unit: "cups"),
        Ingredient(name: "Sashimi-grade Tuna", amount: 300.0, unit: "g"),
        Ingredient(name: "Rice Vinegar", amount: 3.0, unit: "tbsp"),
        Ingredient(name: "Fresh Wasabi", amount: 1.0, unit: "tbsp"),
      ],
    ),
    RecipeModel(
      id: 7,
      title: "Classic Pad Thai",
      chefName: "Thitid Tassanakajohn",
      chefCountry: "Thailand",
      recipeCountry: "Thailand",
      description:
          "Thailand's beloved stir-fried noodle dish balancing sweet, sour, salty, and smoky wok flavors.",
      recipeProcedure: [
        "Soak rice noodles in warm water until flexible but not mushy.",
        "Make a sauce with tamarind, fish sauce, and palm sugar.",
        "Stir-fry egg, tofu, and shrimp in a very hot wok.",
        "Add noodles and toss with sauce until glossy and tender.",
        "Fold in bean sprouts and garlic chives at the end.",
        "Serve with peanuts, lime, and chili flakes.",
      ],
      recipeImageUrl_1:
          "https://img.freepik.com/free-psd/delicious-shrimp-noodle-bowl-with-fresh-vegetables-sesame-seeds_84443-64197.jpg?semt=ais_hybrid&w=740&q=80",
      recipeImageUrl_2:
          "https://png.pngtree.com/thumb_back/fh260/background/20240723/pngtree-thai-food-pad-thai-thai-national-dish-pad-thai-on-black-image_15911824.jpg",
      recipeRating: 4.8,
      time: 35.0,
      calories: 590,
      servings: "1-2",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Rice Noodles", amount: 200.0, unit: "g"),
        Ingredient(name: "Fresh Prawns", amount: 250.0, unit: "g"),
        Ingredient(name: "Tamarind Paste", amount: 3.0, unit: "tbsp"),
        Ingredient(name: "Roasted Peanuts", amount: 0.5, unit: "cup"),
      ],
    ),
    RecipeModel(
      id: 8,
      title: "Peruvian Classic Ceviche",
      chefName: "Gastón Acurio",
      chefCountry: "Peru",
      recipeCountry: "Peru",
      description:
          "A bright Peruvian seafood dish where fresh fish is quickly cured in citrus and served chilled.",
      recipeProcedure: [
        "Dice very fresh white fish into bite-sized cubes and keep it cold.",
        "Season with salt, then cover with fresh lime juice.",
        "Add thin sliced red onion and finely chopped chili.",
        "Marinate briefly until fish edges turn opaque.",
        "Fold in cilantro and taste for salt and acidity.",
        "Serve immediately with sweet potato and corn.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/052/242/051/non_2x/classic-peruvian-ceviche-served-with-lime-and-cilantro-free-png.png",
      recipeImageUrl_2:
          "https://hips.hearstapps.com/hmg-prod/images/delish-230508-peruviancevicheclasico-03-de-copy-647eb6f9eb5c4.jpg?crop=1.00xw:0.704xh;0,0.296xh&resize=640:*",
      recipeRating: 4.9,
      time: 20.0,
      calories: 260,
      servings: "1-2",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Fresh Sea Bass", amount: 500.0, unit: "g"),
        Ingredient(name: "Fresh Lime Juice", amount: 1.0, unit: "cup"),
        Ingredient(name: "Red Onion", amount: 1.0, unit: "medium"),
        Ingredient(name: "Aji Limo (Chili)", amount: 1.0, unit: "piece"),
      ],
    ),
    RecipeModel(
      id: 9,
      title: "Traditional Peking Duck",
      chefName: "Ken Hom",
      chefCountry: "United States",
      recipeCountry: "China",
      description:
          "A famous Chinese banquet dish known for lacquered crispy skin, carved duck slices, and pancakes.",
      recipeProcedure: [
        "Prepare and clean the duck, then separate skin from meat as much as possible.",
        "Scald briefly with boiling water to tighten the skin.",
        "Coat with maltose glaze and hang uncovered to dry for at least 24 hours.",
        "Roast at high heat until skin is deeply golden and crisp.",
        "Rest and carve skin and meat into thin slices.",
        "Serve with mandarin pancakes, hoisin sauce, and scallions.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/057/447/325/non_2x/delicious-peking-duck-elegantly-plated-with-fresh-vegetables-and-greens-for-a-satisfying-meal-top-view-delicious-peking-duck-food-plate-on-a-transparent-background-free-png.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/04/42/52/11/360_F_442521186_XCMUBsPTLSnRQ12zvMjl8GYsD6bqGmw4.jpg",
      recipeRating: 4.7,
      time: 1440.0,
      calories: 840,
      servings: "3-4",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Whole Duck", amount: 1.0, unit: "piece"),
        Ingredient(name: "Maltose Syrup", amount: 3.0, unit: "tbsp"),
        Ingredient(name: "Mandarin Pancakes", amount: 20.0, unit: "pieces"),
        Ingredient(name: "Hoisin Sauce", amount: 0.5, unit: "cup"),
      ],
    ),
    RecipeModel(
      id: 10,
      title: "French Butter Croissant",
      chefName: "Cédric Grolet",
      chefCountry: "France",
      recipeCountry: "France",
      description:
          "An iconic laminated pastry made from yeasted dough and butter layers for a flaky, airy crumb.",
      recipeProcedure: [
        "Mix dough ingredients and knead until smooth, then chill overnight.",
        "Shape cold butter into a flat block and lock it inside the dough.",
        "Roll and fold the dough in several turns, chilling between each turn.",
        "Roll final sheet and cut into long triangles.",
        "Shape croissants from base to tip and proof until puffy.",
        "Brush with egg wash and bake until deeply golden and crisp.",
      ],
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/thumbnails/044/763/461/small_2x/croissant-french-pastry-croissant-top-view-puff-pastry-dessert-isolated-png.png",
      recipeImageUrl_2:
          "https://delifrance.com/media/wysiwyg/Recettes/recettes-menu-dlf.png",
      recipeRating: 5.0,
      time: 360.0,
      calories: 300,
      servings: "1-2",
      isFavorite: false,
      ingredients: [
        Ingredient(name: "Bread Flour", amount: 500.0, unit: "g"),
        Ingredient(name: "European Butter", amount: 250.0, unit: "g"),
        Ingredient(name: "Active Dry Yeast", amount: 10.0, unit: "g"),
        Ingredient(name: "Whole Milk", amount: 150.0, unit: "ml"),
      ],
    ),
  ];
}
