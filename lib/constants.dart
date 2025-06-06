const List<Map<String, String>> technicalOptions = [
  {'name': 'DIMENSIONS', 'icon': 'assets/icons_dimensions.png'},
  {'name': 'TYRES', 'icon': 'assets/Tyres.png'},
  {'name': 'SPECIFICATIONS', 'icon': 'assets/Specification.png'},
  {'name': 'OPTIONS', 'icon': 'assets/options.png'},
  {'name': 'ENGINE', 'icon': 'assets/engine.png'},
  {'name': 'AXLES', 'icon': 'assets/Axles.png'},
  {'name': 'BRAKES', 'icon': 'assets/Breakes.png'},
  {'name': 'SPEED', 'icon': 'assets/speed.png'},
  {'name': 'TRANSMISSION', 'icon': 'assets/Transmission.png'},
  {'name': 'STEERING', 'icon': 'assets/steering.png'},
  {'name': 'ELETRICALS', 'icon': 'assets/electrical-resistance.png'},
  {'name': 'HYDRAULICS', 'icon': 'assets/fluent_pipeline-20-filled.png'},
  {'name': 'CABINET\nFEATURES', 'icon': 'assets/Cabinet.png'},
  {'name': 'TURNING\nCIRCLES', 'icon': 'assets/Turning_circles.png'},
  {'name': 'SERVICE\nCAPACITIES', 'icon': 'assets/Services.png'},
  {'name': 'WEIGHT', 'icon': 'assets/weight-sharp.png'},
];

const List<Map<String, dynamic>> bucketOptions = [
  {
    'name': 'Standard Bucket',
    'images': [
      'assets/Buckets_items/fa0d04b2501bfb64af930056b1d44b20fb5de7ba.png',
      'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
      'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
    ],
  },
  {
    'name': 'Heavy Duty Bucket',
    'images': [
      'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
      'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
    ],
  },
  {
    'name': 'Rock Bucket',
    'images': [
      'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
      'assets/Buckets_items/49fc2c52cc71b4cfa202ed5b920905180fc7b265.png',
    ],
  },
  {
    'name': 'Multi-Purpose Bucket',
    'images': [
      'assets/Buckets_items/ef751c2946ec9aef31f736278688e527bcbf3c92.png',
      'assets/Buckets_items/d9a6311a5589c0ab6ff2923201fabca78dbe22d1.png',
    ],
  },
  {
    'name': 'Multi-Purpose Bucket',
    'images': [
      'assets/Buckets_items/f23320b76f04cb97e31ef08630860c6e9d5d80ee.png',
      'assets/Buckets_items/ef751c2946ec9aef31f736278688e527bcbf3c92.png',
    ],
  },
  {
    'name': 'Multi-Purpose Bucket',
    'images': [
      'assets/Buckets_items/fa0d04b2501bfb64af930056b1d44b20fb5de7ba.png',
      'assets/Buckets_items/multi_purpose_3_2.png',
    ],
  },
  {
    'name': '14 FEET EXT BALE',
    'images': [
      'assets/Buckets_items/3ad530d3dd56226fac05ed7950790d79368c0608.jpg',
      'assets/Buckets_items/multi_purpose_4_2.jpg',
    ],
  },
];

const Map<String, String> bucketDescriptions = {
  'Standard Bucket':
  'General-purpose bucket for light to medium tasks. Constructed from high-strength steel for durability. Ideal for digging, loading, and material handling. Features balanced capacity and durable cutting edges. Suitable for construction and landscaping.',
  'Heavy Duty Bucket':
  'Built for tough, abrasive conditions. Made with reinforced high-strength steel and wear plates. Designed for heavy excavation and quarrying. Offers enhanced durability and larger capacity. Perfect for demanding construction environments.',
  'Rock Bucket':
  'Specialized for rocky terrains and heavy debris. Constructed with hardened steel and reinforced tines. Ideal for rock removal and demolition tasks. Slotted design allows sifting with high impact resistance. Suited for rugged quarry and mining applications.',
  'Multi-Purpose Bucket':
  'Versatile bucket for diverse tasks. Made from high-strength steel with hydraulic components. Supports grading, grappling, dozing, and digging. Clamshell design with adjustable jaws for flexibility. Ideal for multi-task construction and landscaping.',
  '14 FEET EXT BALE':
  'Designed for handling large bales and bulk materials. Constructed with high-strength steel for durability. Features extended reach for efficient loading. Ideal for agricultural and heavy-duty material handling tasks.'
};

const Map<String, List<Map<String, String>>> bucketSpecifications = {
  'Standard Bucket': [
    {'Specification': 'Capacity', 'Unit': 'm³', 'Weight': '400 kg'},
    {'Specification': 'Width', 'Unit': 'mm', 'Weight': '1800 mm'},
    {'Specification': 'Material', 'Unit': '-', 'Weight': 'High-strength steel'},
  ],
  'Heavy Duty Bucket': [
    {'Specification': 'Capacity', 'Unit': 'm³', 'Weight': '600 kg'},
    {'Specification': 'Width', 'Unit': 'mm', 'Weight': '2000 mm'},
    {'Specification': 'Material', 'Unit': '-', 'Weight': 'Reinforced steel'},
    {'Specification': 'Wear Plates', 'Unit': '-', 'Weight': 'Yes'},
  ],
  'Rock Bucket': [
    {'Specification': 'Capacity', 'Unit': 'm³', 'Weight': '550 kg'},
    {'Specification': 'Width', 'Unit': 'mm', 'Weight': '1900 mm'},
    {'Specification': 'Tines', 'Unit': '-', 'Weight': 'Hardened steel'},
  ],
  'Multi-Purpose Bucket': [
    {'Specification': 'Capacity', 'Unit': 'm³', 'Weight': '500 kg'},
    {'Specification': 'Width', 'Unit': 'mm', 'Weight': '1850 mm'},
    {'Specification': 'Hydraulics', 'Unit': '-', 'Weight': 'Clamshell design'},
  ],
  '14 FEET EXT BALE': [
    {'Specification': 'Capacity', 'Unit': 'm³', 'Weight': '550 kg'},
    {'Specification': 'Width', 'Unit': 'mm', 'Weight': '1050 mm'},
    {'Specification': 'Hydraulics', 'Unit': '-', 'Weight': 'Raw Clap design'},
  ],
};