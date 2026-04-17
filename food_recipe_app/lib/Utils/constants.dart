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
      recipeProcedure:
          "First, season the beef fillet generously and sear it in a smoking hot pan with olive oil until perfectly browned on all sides. Brush the warm beef with English mustard. Finely chop mushrooms and sauté them with thyme and garlic until all moisture evaporates, creating a dry duxelles paste. Lay overlapping slices of prosciutto on a sheet of plastic wrap, spread the mushroom duxelles evenly, and wrap the beef tightly into a neat cylinder. Chill for 15 minutes. Roll out a sheet of puff pastry, place the chilled beef in the center, and wrap it securely. Brush with egg wash, lightly score the top, and bake at 200°C (400°F) for 35 minutes until golden and crisp. Rest for 10 minutes before slicing.",
      recipeImageUrl_1:
          "https://as2.ftcdn.net/v2/jpg/03/08/40/41/1000_F_308404151_AKfZDmP5gyA5kd1j8dpgI3pkCbbqQMQR.jpg",
      recipeImageUrl_2:
          "https://miro.medium.com/v2/resize:fit:1100/format:webp/1*hZ7Qf44gByCY246rC72buw.jpeg",
      recipeRating: 4.9,
      time: 120.0,
      isFavorite: true,
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
      recipeProcedure:
          "Boil a large pot of salted water and cook the spaghetti until al dente. In a separate bowl, heavily whisk the egg yolks with freshly grated Pecorino Romano cheese and a generous amount of black pepper to form a thick paste. Meanwhile, slice the guanciale (cured pork cheek) into thick strips and fry it in a cold skillet over medium heat until the fat renders out and the edges become crispy. Remove the pan from the heat. Transfer the cooked pasta directly into the skillet with the guanciale. Quickly stir in the egg and cheese mixture, adding a little pasta water vigorously until a smooth, creamy sauce forms. Serve immediately with extra cheese.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/056/615/020/non_2x/spaghetti-carbonara-top-view-isolate-on-transparent-background-png.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/16/80/22/81/360_F_1680228193_2PLSqk9WOXuYUSIUsaH3OFkOsyUV3Wun.jpg",
      recipeRating: 4.8,
      time: 25.0,
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
      recipeProcedure:
          "Marinate chicken pieces in yogurt, ginger-garlic paste, lemon juice, and a blend of Kashmiri red chili, garam masala, and turmeric for at least 3 hours. Roast the marinated chicken in an oven or tandoor until slightly charred. For the gravy, simmer fresh tomatoes with garlic, cardamom, and cloves until extremely soft. Blend the tomato mixture into a fine puree and strain it for a silky texture. Heat butter in a pan, add the tomato puree, kasoori methi (dried fenugreek leaves), and simmer until the sauce thickens. Finally, add the roasted chicken pieces and finish with a heavy pour of fresh cream. Simmer for 5 more minutes.",
      recipeImageUrl_1:
          "https://masalaandchai.com/wp-content/uploads/2022/03/Butter-Chicken-500x375.jpg",
      recipeImageUrl_2:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480/img/recipe/ras/Assets/89d5040a3e50962bd1fd9acc10c56347/Derivates/feec59de260737f0f037c6f0af6a4068482c9b76.jpg",
      recipeRating: 5.0,
      time: 65.0,
      isFavorite: true,
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
      recipeProcedure:
          "Start by making a piperade: sauté finely diced onions, garlic, and bell peppers in olive oil until soft, then add crushed tomatoes and herbs, simmering until reduced to a rich sauce. Spread this sauce evenly at the bottom of a round baking dish. Using a mandoline, thinly and uniformly slice zucchini, yellow squash, Japanese eggplant, and Roma tomatoes. Arrange the vegetable slices tightly in an alternating, overlapping circular pattern over the sauce. Drizzle generously with olive oil, garlic, and fresh thyme leaves. Cover with parchment paper and bake at 150°C (300°F) for 90 minutes until the vegetables are completely tender but still hold their shape.",
      recipeImageUrl_1:
          "https://png.pngtree.com/png-clipart/20240325/original/pngtree-ratatouille-french-food-png-image_14674078.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/04/51/46/05/360_F_451460502_Vkvu7sif3k0nCkGgkkcLJ0mQWDGvRq0x.jpg",
      recipeRating: 4.7,
      time: 110.0,
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
      recipeProcedure:
          "Create an adobo marinade by blending rehydrated guajillo and ancho chilies, achiote paste, garlic, oregano, cumin, vinegar, and pineapple juice until smooth. Thinly slice pork shoulder and coat the meat thoroughly with the marinade, letting it rest overnight. Traditionally, the meat is stacked onto a vertical spit (trompo) with a slice of pineapple on top and roasted slowly. At home, you can tightly pack the marinated pork into a loaf pan, bake until tender, and then crisp the sliced meat in a hot skillet. Serve immediately on warm corn tortillas, garnished with finely diced white onions, fresh cilantro, and roasted pineapple chunks.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/057/174/788/non_2x/deliciously-crafted-tacos-al-pastor-on-a-transparent-plate-garnished-with-lime-and-fresh-cilantro-top-view-delicious-tacos-al-pastor-food-plate-on-a-transparent-background-free-png.png",
      recipeImageUrl_2:
          "https://static.vecteezy.com/system/resources/previews/029/249/722/non_2x/top-view-delicious-tacos-al-pastor-food-plate-on-a-transparent-background-ai-generated-png.png",
      recipeRating: 4.9,
      time: 240.0,
      isFavorite: true,
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
      recipeProcedure:
          "Rinse short-grain sushi rice repeatedly until the water runs completely clear, then cook it gently. While still warm, fold in a mixture of rice vinegar, sugar, and salt, fanning the rice rapidly to give it a glossy finish. Let it cool to body temperature. Carefully slice high-quality, sashimi-grade bluefin tuna into neat, rectangular pieces against the grain. Moisten your hands with vinegared water to prevent sticking. Take a small amount of rice and gently shape it into an oval. Dab a tiny amount of fresh wasabi onto the underside of the tuna slice, then drape the fish over the rice, pressing gently to fuse them together.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/054/720/739/non_2x/delicious-tuna-sushi-nigiri-on-transparent-background-png.png",
      recipeImageUrl_2:
          "https://i.ytimg.com/vi/BoNwXGkRRLw/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDjfD7RXtwlgZZnd6HVCDs_sOCSlQ",
      recipeRating: 5.0,
      time: 60.0,
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
      recipeProcedure:
          "Soak flat rice noodles in warm water until pliable but still firm. Prepare the Pad Thai sauce by dissolving palm sugar into tamarind paste and fish sauce over low heat. In a searing hot wok, scramble an egg with a little oil. Push it to the side, then add firm tofu cubes, dried shrimp, and fresh prawns, stir-frying rapidly. Add the drained noodles and the prepared tamarind sauce, tossing continuously until the noodles absorb the liquid and soften. Quickly fold in fresh bean sprouts and garlic chives. Serve immediately with crushed roasted peanuts, a lime wedge, and chili flakes on the side.",
      recipeImageUrl_1:
          "https://img.freepik.com/free-psd/delicious-shrimp-noodle-bowl-with-fresh-vegetables-sesame-seeds_84443-64197.jpg?semt=ais_hybrid&w=740&q=80",
      recipeImageUrl_2:
          "https://png.pngtree.com/thumb_back/fh260/background/20240723/pngtree-thai-food-pad-thai-thai-national-dish-pad-thai-on-black-image_15911824.jpg",
      recipeRating: 4.8,
      time: 35.0,
      isFavorite: true,
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
      recipeProcedure:
          "Start with extremely fresh, firm white fish (like sea bass or flounder), cutting it into uniform, bite-sized cubes. Place the fish in a glass bowl set over ice to keep it very cold. Season the fish generously with fine sea salt. Squeeze fresh lime juice directly over the fish, ensuring it is completely submerged. Add very thinly sliced red onions and finely chopped aji limo (or habanero peppers). Let the mixture marinate (cook in the acid) for exactly 5 to 10 minutes until the outside of the fish turns opaque. Gently fold in fresh cilantro leaves. Serve immediately with sweet potato slices and large-kernel Andean corn.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/052/242/051/non_2x/classic-peruvian-ceviche-served-with-lime-and-cilantro-free-png.png",
      recipeImageUrl_2:
          "https://hips.hearstapps.com/hmg-prod/images/delish-230508-peruviancevicheclasico-03-de-copy-647eb6f9eb5c4.jpg?crop=1.00xw:0.704xh;0,0.296xh&resize=640:*",
      recipeRating: 4.9,
      time: 20.0,
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
      recipeProcedure:
          "This is a multi-day process. First, air must be pumped between the duck's skin and meat to separate them. Next, plunge the duck into boiling water briefly to tighten the skin. Glaze the entire bird with a mixture of maltose syrup and soy sauce. Hang the duck in a cool, well-ventilated area to dry completely for at least 24 hours. Once the skin feels like parchment paper, roast the duck in a hot oven (around 200°C) until the fat renders out and the skin turns crispy and mahogany brown. Slice the extremely crispy skin and tender meat separately, serving them inside thin steamed mandarin pancakes with hoisin sauce and julienned scallions.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/previews/057/447/325/non_2x/delicious-peking-duck-elegantly-plated-with-fresh-vegetables-and-greens-for-a-satisfying-meal-top-view-delicious-peking-duck-food-plate-on-a-transparent-background-free-png.png",
      recipeImageUrl_2:
          "https://t4.ftcdn.net/jpg/04/42/52/11/360_F_442521186_XCMUBsPTLSnRQ12zvMjl8GYsD6bqGmw4.jpg",
      recipeRating: 4.7,
      time: 1440.0,
      isFavorite: true,
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
      recipeProcedure:
          "Mix flour, water, milk, sugar, salt, and yeast into a smooth dough. Let it ferment overnight in the fridge. The next day, pound a block of high-quality European butter into a flat square. Roll out the cold dough, enclose the butter block inside it, and perform a series of folds (lamination) – rolling it out and folding it like a letter, chilling it in between each turn. After three complete turns and final resting, roll the dough thin and cut it into elongated triangles. Stretch each triangle slightly, roll it up tightly from the base to the tip, and let them proof until doubled in size and jiggly. Brush with egg wash and bake at 190°C (375°F) until perfectly flaky, dark golden, and crisp.",
      recipeImageUrl_1:
          "https://static.vecteezy.com/system/resources/thumbnails/044/763/461/small_2x/croissant-french-pastry-croissant-top-view-puff-pastry-dessert-isolated-png.png",
      recipeImageUrl_2:
          "https://delifrance.com/media/wysiwyg/Recettes/recettes-menu-dlf.png",
      recipeRating: 5.0,
      time: 360.0,
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
