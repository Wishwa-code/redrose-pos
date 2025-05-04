import 'package:flutter/foundation.dart'; // Only needed if using @immutable

// 1. TreeNode Class
@immutable // Optional: Good practice for data classes that shouldn't change
class TreeNode {
  // Const constructor for potential performance benefits and immutability
  const TreeNode({
    required this.index,
    required this.available,
    required this.isFolder,
    required this.children,
    required this.data,
    required this.level,
    required this.image,
    required this.sinhalaName,
  });
  final String index;
  final bool available;
  final bool isFolder;
  final List<String> children;
  final String data;
  final int level; // Using int for level as it's typically whole numbers
  final String image;
  final String sinhalaName;

  // Optional: Add methods like copyWith, toJson, fromJson if needed later
  // Optional: Add toString for easier debugging
  @override
  String toString() {
    return 'TreeNode(index: $index, data: $data, isFolder: $isFolder, children: ${children.length})';
  }

  // Optional: Add equality and hashCode overrides if storing in Sets or using as Map keys
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TreeNode &&
        other.index == index &&
        other.available == available &&
        other.isFolder == isFolder &&
        listEquals(other.children, children) && // Use listEquals for list comparison
        other.data == data &&
        other.level == level &&
        other.image == image;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        available.hashCode ^
        isFolder.hashCode ^
        children.hashCode ^ // Default list hashCode is usually sufficient
        data.hashCode ^
        level.hashCode ^
        image.hashCode;
  }
}

// 2. Tree Type Equivalent (Using Map directly)
// No direct 'type' alias needed, just use Map<String, TreeNode>

// 3. Constants and Data
const String imageUrl =
    'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/43e3dbcc-f776-46fc-8977-235a055c1b5d_1.bd7990a8ac3ad38c7b88480fb3996077.jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy80M2UzZGJjYy1mNzc2LTQ2ZmMtODk3Ny0yMzVhMDU1YzFiNWRfMS5iZDc5OTBhOGFjM2FkMzhjN2I4ODQ4MGZiMzk5NjA3Ny5qcGVnIiwiaWF0IjoxNzQwMjEzMDI5LCJleHAiOjE3NzE3NDkwMjl9.Al_XbnJ42f0w79uwEElSNtQwlYezZrLoCmo9YpmlR1s';
final Map<String, TreeNode> items = {
  'root': const TreeNode(
    index: 'root',
    available: true,
    isFolder: true,
    children: <String>[
      'mainBuilding',
      'mainTools',
      'mainPaint',
      'mainroofingandceiling',
      'mainsteel',
      'maingardenanddecoration',
      'maingeneralhardware',
      'mainsafety',
      'mainelectrical',
      'mainplumbing',
      'maintileaccesories',
      'mainindustrial',
      'mainfasterners',
      'mainhomekitchen',
      'maingiftitems',
    ],
    data: 'Menu',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මුල', // Added
  ),

  //? roofiung sheets starts from here
  'mainroofingandceiling': const TreeNode(
    index: 'mainroofingandceiling',
    available: true,
    isFolder: true,
    children: <String>['roofingsheets', 'ceilingsheets', 'roofingaccesories', 'ceilingaccesories'],
    data: 'Roofing & Ceiling',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වහල් සහ සිවිලිං', // Added
  ),
  'roofingsheets': const TreeNode(
    index: 'roofingsheets',
    available: true,
    isFolder: true,
    children: <String>[
      'asbestosroofingsheets',
      'asbestoscolorroofingsheets',
      'nonasbestoscolorroofingsheets',
      'ecofreindlyroofingsheets',
      'zincalluminiumroofingsheets',
    ],
    data: 'Roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වහල් ෂීට්', // Added
  ),
  'asbestosroofingsheets': const TreeNode(
    index: 'asbestosroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Asbestos roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇස්බෙස්ටෝස් රැෆින්ග් ෂීට්', // Added
  ),
  'asbestoscolorroofingsheets': const TreeNode(
    index: 'asbestoscolorroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Asbestos color roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇස්බේස්ටෝස් රෑෆින්ග් ෂීට් (පාට)', // Added
  ),
  'nonasbestoscolorroofingsheets': const TreeNode(
    index: 'nonasbestoscolorroofingsheets',
    available: true,
    isFolder: true,
    children: <String>['fiberroofingsheets', 'upvcroofingsheets', 'transparentroofingsheets'],
    data: 'Non asbestos sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇස්බැස්ටෝස් නොවන ෂී්ට්', // Added
  ),
  'fiberroofingsheets': const TreeNode(
    index: 'fiberroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Fiber roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ෆයිබර් රෑෆන්ග් ෂීට්', // Added
  ),
  'upvcroofingsheets': const TreeNode(
    index: 'upvcroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'UPVC roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'U PVC රෑෆින්ග් ෂීට්', // Added
  ),
  'transparentroofingsheets': const TreeNode(
    index: 'transparentroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Transparent roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විනිවිද පෙනෙන ෂීට්', // Added
  ),
  'ecofreindlyroofingsheets': const TreeNode(
    index: 'ecofreindlyroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Eco freindly roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පරිසර හිතකාමී ෂීට්', // Added
  ),
  'zincalluminiumroofingsheets': const TreeNode(
    index: 'zincalluminiumroofingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Zinc alluminium roofing sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සින්ක් ඇලුමිනියම් ෂීට්', // Added
  ),
  'ceilingsheets': const TreeNode(
    index: 'ceilingsheets',
    available: true,
    isFolder: true,
    children: <String>['asbestosceilingsheets', 'nonasbestosceilingsheets'],
    data: 'Ceiling sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සිවිලිං ෂීට්', // Added
  ),
  'asbestosceilingsheets': const TreeNode(
    index: 'asbestosceilingsheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Asbestos ceiling sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇස්බැස්ටෝස් සිවිලිං ෂීට්', // Added
  ),
  'nonasbestosceilingsheets': const TreeNode(
    index: 'nonasbestosceilingsheets',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Non asbestos ceiling sheets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇස්බැස්ටෝස් නොවන සිවිලිං ෂීට්', // Added
  ),
  'roofingaccesories': const TreeNode(
    index: 'roofingaccesories',
    available: true,
    isFolder: true,
    children: <String>['gutterandaccesories', 'ridge', 'foil'],
    data: 'Roofing accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වහල් උපාංග', // Added
  ),
  'gutterandaccesories': const TreeNode(
    index: 'gutterandaccesories',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Gutter & accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කාණු', // Added
  ),
  'ridge': const TreeNode(
    index: 'ridge',
    available: true,
    isFolder: true,
    children: <String>['asbestos', 'fiber'],
    data: 'Ridge',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මුදුන්', // Added
  ),
  'foil': const TreeNode(
    index: 'foil',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Foil',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පරිවරණ තීරු', // Added
  ),

  'ceilingaccesories': const TreeNode(
    index: 'ceilingaccesories',
    available: true,
    isFolder: false,
    children: <String>[], // Corrected: Empty list instead of ['']
    data: 'Ceiling accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සිවිලිං උපාංග', // Added
  ),

  //? mainsteel starts from here
  'mainsteel': const TreeNode(
    index: 'mainsteel',
    available: true,
    isFolder: true,
    children: <String>[
      'qtbar',
      'flatSquareRound',
      'hclselection',
      'pipesTubes',
      'scafoldingEquipment',
      'sheetsPlatesChqPlates',
      'qtbar',
      'mssheets',
    ],
    data: 'Steel',
    level: 0,
    image: imageUrl,
    sinhalaName: 'යකඩ', // Added
  ),
  'qtbar': const TreeNode(
    index: 'qtbar',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'QT bar (Quench and Self-Tempered Re-Bars)',
    level: 0,
    image: imageUrl,
    sinhalaName: 'දගර කම්බි', // Added
  ),
  'flatSquareRound': const TreeNode(
    index: 'flatSquareRound',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Flat, Square & Round Products',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පට්ටම් සහ ‌රවුම්, කොටු, පැතලි යකඩ', // Added
  ),
  'hclselection': const TreeNode(
    index: 'hclselection',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'H, C & L Selection',
    level: 0,
    image: imageUrl,
    sinhalaName: 'H , C, L හැඩැති යකඩ බාර්', // Added
  ),
  'pipesTubes': const TreeNode(
    index: 'pipesTubes',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Pipes & Tubes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පයිප්ප & ටියුබ්', // Added
  ),
  'scafoldingEquipment': const TreeNode(
    index: 'scafoldingEquipment',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Scaffolding Equipment',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පලංචි', // Added
  ),
  'sheetsPlatesChqPlates': const TreeNode(
    index: 'sheetsPlatesChqPlates',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Sheets & Plates, Chq Plates',
    level: 0,
    image: imageUrl,
    sinhalaName: 'යකඩ තහඩු', // Added
  ),
  'mssheets': const TreeNode(
    index: 'mssheets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'MS plate',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මෘදු වානේ තහඩු', // Added
  ),

  'maingardenanddecoration': const TreeNode(
    index: 'maingardenanddecoration',
    available: true,
    isFolder: true,
    children: <String>[
      'lawnandgarden',
      'pavingstones',
      'grassandplants',
      'naturalpebbles',
      'fencing',
      'agricultureproducts',
    ],
    data: 'Garden & Decoration',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කෘෂිකර්මාන්තය සහ ගෙවතු වගාව', // Added
  ),
  'lawnandgarden': const TreeNode(
    index: 'lawnandgarden',
    available: true,
    isFolder: true,
    children: <String>['gardeningtools', 'pots', 'wateringsystem'],
    data: 'Lawn and Garden',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගෙවතු වගාව', // Added
  ),
  'gardeningtools': const TreeNode(
    index: 'gardeningtools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Gardening tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගෙවතු වගා උපාංග', // Added
  ),
  'pots': const TreeNode(
    index: 'pots',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Pots',
    level: 0,
    image: imageUrl,
    sinhalaName: 'භාජන', // Added
  ),
  'wateringsystem': const TreeNode(
    index: 'wateringsystem',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Watering system',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ජල පද්ධති', // Added
  ),
  'pavingstones': const TreeNode(
    index: 'pavingstones',
    available: true,
    isFolder: true,
    children: <String>['granitepavingstones', 'cementpavingstones'],
    data: 'Paving stones',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බිම අතුරන ගල්', // Added
  ),
  'granitepavingstones': const TreeNode(
    index: 'granitepavingstones',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Granite paving stones',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ග්රැනයිට් ගල්', // Added
  ),
  'cementpavingstones': const TreeNode(
    index: 'cementpavingstones',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Cement paving stones/Interlock',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සිමෙන්ති ගල්', // Added
  ),
  'grassandplants': const TreeNode(
    index: 'grassandplants',
    available: true,
    isFolder: true,
    children: <String>['malaysiancarpet', 'australiancarpet'],
    data: 'Grass & Plants',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තණකොල සහ අලංකාරණ ශාක', // Added
  ),
  'malaysiancarpet': const TreeNode(
    index: 'malaysiancarpet',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Malaysian carpet',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මැලේසියන් තණකොල', // Added
  ),
  'australiancarpet': const TreeNode(
    index: 'australiancarpet',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Australian carpet',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඹස්ටේලියන් තණකොල', // Added
  ),
  'naturalpebbles': const TreeNode(
    index: 'naturalpebbles',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Natural pebbles',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ස්වභාවික ගල් කැට', // Added
  ),
  'fencing': const TreeNode(
    index: 'fencing',
    available: true,
    isFolder: true,
    children: <String>[
      'pvccoatedchainink',
      'pvccoatedlinewire',
      'barbedwire',
      'farmfence',
      'gabions',
    ],
    data: 'Fencing',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වැටවල්', // Added
  ),
  'pvccoatedchainink': const TreeNode(
    index: 'pvccoatedchainink',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'PVC coated chain ink',
    level: 0,
    image: imageUrl,
    sinhalaName: 'PVC ආලේපිත දැල්', // Added
  ),
  'pvccoatedlinewire': const TreeNode(
    index: 'pvccoatedlinewire',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'PVC coated line wire',
    level: 0,
    image: imageUrl,
    sinhalaName: 'PVC ආලේපිත කමබි', // Added
  ),
  'barbedwire': const TreeNode(
    index: 'barbedwire',
    available: true,
    isFolder: true,
    children: <String>['concertinabarbedwire', 'pvccoatedbarbedwire', 'gibarbedwire'],
    data: 'Barbed wire',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කටු කම්බි', // Added
  ),
  'concertinabarbedwire': const TreeNode(
    index: 'concertinabarbedwire',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Concertina barbed wire(camp wire)',
    level: 0,
    image: imageUrl,
    sinhalaName: 'Concertina කටු කම්බි(කඳවුරු කම්බි)', // Added
  ),
  'pvccoatedbarbedwire': const TreeNode(
    index: 'pvccoatedbarbedwire',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'PVC coated barbed wire',
    level: 0,
    image: imageUrl,
    sinhalaName: 'PVC ආලේපිත කටු කම්බි', // Added
  ),
  'gibarbedwire': const TreeNode(
    index: 'gibarbedwire',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'GI barbed wire',
    level: 0,
    image: imageUrl,
    sinhalaName: 'යකඩ කටු කම්බි', // Added
  ),
  'farmfence': const TreeNode(
    index: 'farmfence',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Farm fence',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වගා වැටවල්', // Added
  ),
  'gabions': const TreeNode(
    index: 'gabions',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Gabions',
    level: 0,
    image: imageUrl,
    sinhalaName: 'Gabion දැල්', // Added
  ),
  'agricultureproducts': const TreeNode(
    index: 'agricultureproducts',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Agricultural products',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙනත් උපාංග', // Added
  ),
  'maingeneralhardware': const TreeNode(
    index: 'maingeneralhardware',
    available: true,
    isFolder: true,
    children: <String>[
      'homeaccesories',
      'adhesivetapes',
      'padlock',
      'ropes',
      'haspandstaple',
      'hangersandhooks',
      'bindingwire',
      'brassitems',
      'plasticandpolythene',
    ],
    data: 'General hardware',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සාමාන්‍ය හාඩ්වෙයාර් බඩු', // Added
  ),
  'homeaccesories': const TreeNode(
    index: 'homeaccesories',
    available: true,
    isFolder: true,
    children: <String>['doorandwindows', 'floorsandwalls', 'chaincablerope', 'sinks'],
    data: 'Home accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'නිවස් උපාංග', // Added
  ),

  'doorandwindows': const TreeNode(
    index: 'doorandwindows',
    available: true,
    isFolder: true,
    children: <String>['mascondoors', 'aluminiumdoors', 'hinges', 'plasticdoors'],
    data: 'Doors & Windows',
    level: 0,
    image: imageUrl,
    sinhalaName: 'දොරවල් සහ ජනෙල්', // Added
  ),
  'mascondoors': const TreeNode(
    index: 'mascondoors',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Mascon doors',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මැස්කන් දොරවල්', // Added
  ),
  'aluminiumdoors': const TreeNode(
    index: 'aluminiumdoors',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Aluminium doors',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇලුමිනියම් දොරවල්', // Added
  ),
  'hinges': const TreeNode(
    index: 'hinges',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hinges',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සරනේරු', // Added
  ),
  'plasticdoors': const TreeNode(
    index: 'plasticdoors',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Plastic doors',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ප්ලාස්ටික් දොරවල්', // Added
  ),
  'floorsandwalls': const TreeNode(
    index: 'floorsandwalls',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Floors & Walls',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බිම් සහ බිත්ති', // Added
  ),
  'chaincablerope': const TreeNode(
    index: 'chaincablerope',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Chain, Cable & Rope',
    level: 0,
    image: imageUrl,
    sinhalaName: 'දම්වැල, කේබල්', // Added
  ),
  'sinks': const TreeNode(
    index: 'sinks',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Sinks',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සින්ක්', // Added
  ),
  'adhesivetapes': const TreeNode(
    index: 'adhesivetapes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Adhesive tapes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇලවුම් පටි', // Added
  ),
  'padlock': const TreeNode(
    index: 'padlock',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Padlock',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අගුල', // Added
  ),
  'ropes': const TreeNode(
    index: 'ropes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Ropes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කඹ', // Added
  ),
  'haspandstaple': const TreeNode(
    index: 'haspandstaple',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hasp & Tapes', // Typo in original? Assuming 'Staples'? Keeping original.
    level: 0,
    image: imageUrl,
    sinhalaName: 'කොන්ඩි පට්ටම්', // Added
  ),
  'hangersandhooks': const TreeNode(
    index: 'hangersandhooks',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hangers & Hooks',
    level: 0,
    image: imageUrl,
    sinhalaName: 'එල්ලුම් සහ කොකු', // Added
  ),
  'bindingwire': const TreeNode(
    index: 'bindingwire',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Binding wire',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බයින්ඩින් කම්බි', // Added
  ),
  'brassitems': const TreeNode(
    index: 'brassitems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Brass items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පිත්තල භාණ්ඩ', // Added
  ),
  'plasticandpolythene': const TreeNode(
    index: 'plasticandpolythene',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Plastic & Polythene',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ප්ලාස්ටික් සහ පොලිතීන්', // Added
  ),
  'mainsafety': const TreeNode(
    index: 'mainsafety',
    available: true,
    isFolder: true,
    children: <String>[
      'personalprotectiveequipment',
      'safetyhemets',
      'safetyjacketsandoverall',
      'safetymask',
      'safetygloves',
      'safetygoggles',
      'safetyshoes',
      'gumboots',
      'battonortroublelight',
      'safetyglass',
      'earmuff',
      'safetyrespiratormask',
      'safetybeltandharness',
      'roadsafety',
    ],
    data: 'Safety',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂා උපකරණ', // Added
  ),
  'personalprotectiveequipment': const TreeNode(
    index: 'personalprotectiveequipment',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Personal protective equipment',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පුද්ගලික ආරක්ෂක උපකරණ', // Added
  ),
  'safetyhemets': const TreeNode(
    index: 'safetyhemets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety helmets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත හිස්වැසුම්', // Added
  ),
  'safetyjacketsandoverall': const TreeNode(
    index: 'safetyjacketsandoverall',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety jackets and overall',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත ජැකට් සහ overall ඇදුම්ඇදුම්', // Added
  ),
  'safetymask': const TreeNode(
    index: 'safetymask',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety mask',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත වෙස් මුහුණ', // Added
  ),
  'safetygloves': const TreeNode(
    index: 'safetygloves',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety gloves',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත අත්වැසුම්', // Added
  ),
  'safetygoggles': const TreeNode(
    index: 'safetygoggles',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety goggles',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත ඇස් කණ්ණාඩි', // Added
  ),
  'safetyshoes': const TreeNode(
    index: 'safetyshoes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety shoes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත සපත්තු', // Added
  ),
  'gumboots': const TreeNode(
    index: 'gumboots',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Gum boots',
    level: 0,
    image: imageUrl,
    sinhalaName: 'GUM බූට්ස්', // Added
  ),
  'battonortroublelight': const TreeNode(
    index: 'battonortroublelight',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Baton light & Trouble light',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බැටන් සහ troublelight', // Added
  ),
  'safetyglass': const TreeNode(
    index: 'safetyglass',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety glass',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත වීදුරු', // Added
  ),
  'earmuff': const TreeNode(
    index: 'earmuff',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Ear muff',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කන් ආවරණ', // Added
  ),
  'safetyrespiratormask': const TreeNode(
    index: 'safetyrespiratormask',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety respirator mask',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත ශ්වසන ආවරණ', // Added
  ),
  'safetybeltandharness': const TreeNode(
    index: 'safetybeltandharness',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Safety belt and harness',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ආරක්ෂිත පටි සහ පටි ඇදුම්', // Added
  ),
  'roadsafety': const TreeNode(
    index: 'roadsafety',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Road safety',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මාර්ග ආරක්ෂා', // Added
  ),

  //?electrical deportment start from here
  'mainelectrical': const TreeNode(
    index: 'mainelectrical',
    available: true,
    isFolder: true,
    children: <String>['lighting', 'homeappliances', 'accesories', 'conduits'],
    data: 'Electrical',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි උපාංග', // Added
  ),
  'lighting': const TreeNode(
    index: 'lighting',
    available: true,
    isFolder: true,
    children: <String>['cfl', 'led', 'panellights', 'decolights', 'quartz', 'fluorecent'],
    data: 'Lighting',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි බලබ්', // Added
  ),
  'cfl': const TreeNode(
    index: 'cfl',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'CFL',
    level: 0,
    image: imageUrl,
    sinhalaName: 'CFL', // Added
  ),
  'led': const TreeNode(
    index: 'led',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'LED',
    level: 0,
    image: imageUrl,
    sinhalaName: 'LED', // Added
  ),
  'panellights': const TreeNode(
    index: 'panellights',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Panel lights',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පැනල් ලයිට්', // Added
  ),
  'decolights': const TreeNode(
    index: 'decolights',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Deco lights',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අලංකරණ ලයිට්ලයිට්', // Added
  ),
  'quartz': const TreeNode(
    index: 'quartz',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Quartz',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ටංස්ටන් හැලජන් ලාම්පු', // Added
  ),
  'fluorecent': const TreeNode(
    index: 'fluorecent',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Fluorecent tubes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'flurocent', // Added
  ),
  'lightingaccesories': const TreeNode(
    index: 'lightingaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Lighting Accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි උපාංග', // Added
  ),
  'homeappliances': const TreeNode(
    index: 'homeappliances',
    available: true,
    isFolder: true,
    children: <String>['fans'],
    data: 'Home appliances',
    level: 0,
    image: imageUrl,
    sinhalaName: 'නිවස් විදුලි උපාංග', // Added
  ),
  'fans': const TreeNode(
    index: 'fans',
    available: true,
    isFolder: false, // Changed to false based on children list
    children: <String>[], // Assuming these are final items, not sub-folders? If they are sub-folders, change isFolder back to true.
    data: 'Fans',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ෆෑන් වර්ග', // Added
  ),
  'accesories': const TreeNode(
    index: 'accesories',
    available: true,
    isFolder: true,
    children: <String>[
      'alliedaccesories',
      'switchesandsockets',
      'circuitbreakers',
      'wiresandcables',
      'conduitaccesories',
      'wirecodes',
    ],
    data: 'Accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අමතර විදුලි උපාංග (ස්විච්, බේකර්,...)', // Added
  ),
  'alliedaccesories': const TreeNode(
    index: 'alliedaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Allied accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පිටතින් භාවිතා කල හැකි විදුලි උපාංග', // Added
  ),
  'switchesandsockets': const TreeNode(
    index: 'switchesandsockets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Switches & Sockets',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ස්විච් සහ සොකට්', // Added
  ),
  'circuitbreakers': const TreeNode(
    index: 'circuitbreakers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Circuit breakers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සරකිට් බේකරස්බේකරස්', // Added
  ),
  'wiresandcables': const TreeNode(
    index: 'wiresandcables',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Wires & Cables',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වයර් සහ කේබල්කේබල්', // Added
  ),
  'conduitaccesories': const TreeNode(
    index: 'conduitaccesories',
    available: true,
    isFolder: true,
    children: <String>[
      'conduitpipes',
      'conduitpipesfittings',
      'cabletrucnking',
      'cabletrucnkingfittings',
      'cabletie',
      'wirecodes',
    ],
    data: 'Conduit accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කන්ඩියුට් අමතර උපාංග', // Added
  ),
  'conduitpipes': const TreeNode(
    index: 'conduitpipes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Conduit pipes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කන්ඩියුට් බට', // Added
  ),
  'conduitpipesfittings': const TreeNode(
    index: 'conduitpipesfittings',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Conduit pipes fittins', // Typo in original? fittings?
    level: 0,
    image: imageUrl,
    sinhalaName: 'කන්ඩියුට් ෆිටින්ග්ස්', // Added
  ),
  'cabletrucnking': const TreeNode(
    index: 'cabletrucnking',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Conduit pipes fittins', // Data seems incorrect here, likely 'Cable trunking'
    level: 0,
    image: imageUrl,
    sinhalaName: 'වයර් trunnkcing(conduit කොටු බට)', // Added
  ),
  'cabletrucnkingfittings': const TreeNode(
    index: 'cabletrucnkingfittings',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Cable trunking fittings',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වයර් trunnkcing(conduit කොටු බට) ෆිටින්ග්ස් ', // Added
  ),
  'cabletie': const TreeNode(
    index: 'cabletie',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Cable tie',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කේබල් ටයි පටි', // Added
  ),

  'mainplumbing': const TreeNode(
    index: 'mainplumbing',
    available: true,
    isFolder: true,
    children: <String>['plumbinghardware', 'plumbingtoolsandaccesories', 'bathware'],
    data: 'Plumbing',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ජල නල සහ උපාංග', // Added
  ),
  'plumbinghardware': const TreeNode(
    index: 'plumbinghardware',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Plumbing', // Data seems too general?
    level: 0,
    image: imageUrl,
    sinhalaName: 'ජල නල', // Added
  ),
  'plumbingtoolsandaccesories': const TreeNode(
    index: 'plumbingtoolsandaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Plumbing tools & accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ජල නල උපාංග ', // Added
  ),
  'bathware': const TreeNode(
    index: 'bathware',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Bathware',
    level: 0,
    image: imageUrl,
    sinhalaName: 'නාන කාමර උපකරණ', // Added
  ),
  'maintileaccesories': const TreeNode(
    index: 'maintileaccesories',
    available: true,
    isFolder: true,
    children: <String>['tilegrout'],
    data: 'Tile accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ටයිල්', // Added
  ),
  'tilegrout': const TreeNode(
    index: 'tilegrout',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Tile grout',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ටයිල් grout', // Added
  ),
  'mainfasterners': const TreeNode(
    index: 'mainfasterners',
    available: true,
    isFolder: true,
    children: <String>[
      'anchorbolt',
      'drywallscrews',
      'wirenail',
      'rivetandrivettools',
      'wallplugs',
      'conctreatenails',
      'nutandbolts',
      'bindingwireforbindings',
      'threadbar',
      'umbrellanails',
      'panheadscrew',
      'washers',
    ],
    data: 'Fasterners', // Typo in original? Fasteners?
    level: 0,
    image: imageUrl,
    sinhalaName: 'තද කරන උපාංග', // Added
  ),
  'anchorbolt': const TreeNode(
    index: 'anchorbolt',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Anchorbolt',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇන්කර් බෝල්ට්', // Added
  ),
  'drywallscrews': const TreeNode(
    index: 'drywallscrews',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Dry wall screws',
    level: 0,
    image: imageUrl,
    sinhalaName: 'drywall ස්කුරුප්පු', // Added
  ),
  'wirenail': const TreeNode(
    index: 'wirenail',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Wire nail',
    level: 0,
    image: imageUrl,
    sinhalaName: 'යකඩ ඇණ', // Added
  ),
  'rivetandrivettools': const TreeNode(
    index: 'rivetandrivettools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Rivet and rivet tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රිවට් සහ රිටව් උපාංග', // Added
  ),
  'wallplugs': const TreeNode(
    index: 'wallplugs',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Wall plugs',
    level: 0,
    image: imageUrl,
    sinhalaName: 'wallplugs', // Added
  ),
  'conctreatenails': const TreeNode(
    index: 'conctreatenails',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Concreate nails', // Typo in original? Concrete?
    level: 0,
    image: imageUrl,
    sinhalaName: 'කොන්කීට් ඇණ', // Added
  ),
  'nutandbolts': const TreeNode(
    index: 'nutandbolts',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Nuts & Bolts',
    level: 0,
    image: imageUrl,
    sinhalaName: 'නට් ඇනඩ් බෝල්ට්', // Added
  ),
  'bindingwireforbindings': const TreeNode(
    index: 'bindingwireforbindings',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Binding wire(reevaluatethisnode)', // Note from original data
    level: 0,
    image: imageUrl,
    sinhalaName: 'බයිනඩින් කම්බි', // Added
  ),
  'threadbar': const TreeNode(
    index: 'threadbar',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Thread bar',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ත්රේඩ් බාර්', // Added
  ),
  'umbrellanails': const TreeNode(
    index: 'umbrellanails',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Umbrella nails',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තොප්පි ඇණ', // Added
  ),
  'panheadscrew': const TreeNode(
    index: 'panheadscrew',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Pan head screw',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මල් ස්කුරුප්පු ඇණ', // Added
  ),
  'washers': const TreeNode(
    index: 'washers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Washers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වොෂර්', // Added
  ),
  'mainhomekitchen': const TreeNode(
    index: 'mainhomekitchen',
    available: true,
    isFolder: true,
    children: <String>[
      'cleaningproducts',
      'electricappliancekitchenware',
      'petcareaccesories',
      'householditems',
      'weedsandpestcontrol',
    ],
    data: 'Home & Kitchen',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මුලුතැන්ගේ', // Added
  ),
  'cleaningproducts': const TreeNode(
    index: 'cleaningproducts',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Cleaning products',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පිරිසිදු කිරීමේ නිෂ්පාදන', // Added
  ),
  'electricappliancekitchenware': const TreeNode(
    index: 'electricappliancekitchenware',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Electric appliances & Kitchenware',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මුලුතැන්ගේ විදුලි උපකරණ', // Added
  ),
  'petcareaccesories': const TreeNode(
    index: 'petcareaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Petcare accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සුරතල් සතුන්ගේගේ උපාංග', // Added
  ),
  'householditems': const TreeNode(
    index: 'householditems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'House hold items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගෘහ භාණ්ඩ', // Added
  ),
  'weedsandpestcontrol': const TreeNode(
    index: 'weedsandpestcontrol',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Weeds & Pest control',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වල් පැලෑටි සහ පළිබෝධ පාලනය', // Added
  ),
  'maingiftitems': const TreeNode(
    index: 'maingiftitems',
    available: true,
    isFolder: true,
    children: <String>[
      'vesakdecorationitems',
      'wrappingitems',
      'booksandotheraccesories',
      'craftitems',
      'otherstationeryitems',
    ],
    data: 'Gift items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තෑගි භාණඩ', // Added
  ),
  'vesakdecorationitems': const TreeNode(
    index: 'vesakdecorationitems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Vesak decoration items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙසක් සැරසිලි', // Added
  ),
  'wrappingitems': const TreeNode(
    index: 'wrappingitems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Wrapping items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇසුරුම් අයිතම', // Added
  ),
  'booksandotheraccesories': const TreeNode(
    index: 'booksandotheraccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Books and other accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පොත් සහ පාසල් උපකරණඋපකරණ', // Added
  ),
  'craftitems': const TreeNode(
    index: 'craftitems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Craft items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අත්කම් භාණ්ඩ', // Added
  ),
  'otherstationeryitems': const TreeNode(
    index: 'otherstationeryitems',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Other stationery items',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ලිපි දූව්‍ය', // Added
  ),
  'mainTools': const TreeNode(
    index: 'mainTools',
    available: true,
    isFolder: true,
    children: <String>[
      'powerTools',
      'powerToolaccessories',
      'handtools',
      'layoutandmeasuringtools',
      'masonryTools',
    ],
    data: 'Tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මෙවලම්', // Added
  ),
  'masonryTools': const TreeNode(
    index: 'masonryTools',
    available: false, // Note: Available is false here
    isFolder: true,
    children: <String>[],
    data: 'Masonry Tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පෙදෙරේරු මෙවලම්', // Added
  ),
  'powerTools': const TreeNode(
    index: 'powerTools',
    available: false, // Note: Available is false here
    isFolder: true,
    children: <String>[
      'drills',
      'grinders',
      'polishers',
      'rotarytools',
      'routers',
      'sanders',
      'screwdrivers',
      'saws',
      'aircompressor',
      'otherpowertools',
      'blowers',
      'weldingmachine',
    ],
    data: 'Power Tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි මෙවලම්', // Added
  ),
  'drills': const TreeNode(
    index: 'drills',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Drills',
    level: 0,
    image: imageUrl,
    sinhalaName: '‌ඩිල්ස්', // Added
  ),
  'grinders': const TreeNode(
    index: 'grinders',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Grinders',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගයින්ඩර්ස්', // Added
  ),
  'polishers': const TreeNode(
    index: 'polishers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Polishers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පොලිෂර්ස්පොලිෂර්ස්', // Added
  ),
  'rotarytools': const TreeNode(
    index: 'rotarytools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Rotary tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රොටරි උපාංග', // Added
  ),
  'routers': const TreeNode(
    index: 'routers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Routers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රවුටරස්', // Added
  ),
  'sanders': const TreeNode(
    index: 'sanders',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Sanders',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සැන්ඩර්ස්', // Added
  ),
  'screwdrivers': const TreeNode(
    index: 'screwdrivers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Screw Drivers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පවර් ස්කිරිව් ඩයිවර්ස්', // Added
  ),
  'saws': const TreeNode(
    index: 'saws',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Saws',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පවර් saw', // Added
  ),
  'aircompressor': const TreeNode(
    index: 'aircompressor',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Air Compressor',
    level: 0,
    image: imageUrl,
    sinhalaName: 'air compressor', // Added
  ),
  'blowers': const TreeNode(
    index: 'blowers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Blowers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බ්ලෝවර්ස්', // Added
  ),
  'weldingmachine': const TreeNode(
    index: 'weldingmachine',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Welding Machine',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙල්ඩින්ග් මැෂින්මැෂින්', // Added
  ),
  'otherpowertools': const TreeNode(
    index: 'otherpowertools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Other Power Tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙනත් බලශක්ති ආයුධ', // Added
  ),

  'powerToolaccessories': const TreeNode(
    index: 'powerToolaccessories',
    available: true,
    isFolder: true,
    children: <String>[
      'batteriesandchargers',
      'powerdrillaccesories',
      'impactdriveraccesories',
      'circulartablemitersaw',
      'reciprocatingsawandjigsaw',
      'oscialtingmultitooaccesories',
      'rotarytoolaccesories',
      'grinderAccesories',
      'sanderaccesories',
      'routeraccesories',
      'allpowertoolsaccesories',
    ],
    data: 'Power Tool Accessories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි මෙවලම් උපාංග', // Added
  ),
  'batteriesandchargers': const TreeNode(
    index: 'batteriesandchargers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Batteries and Chargers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'බැටරි සහ චාජර්', // Added
  ),
  'powerdrillaccesories': const TreeNode(
    index: 'powerdrillaccesories',
    available: true,
    isFolder: false,
    children: <String>[], // Corrected from ['']
    data: 'Power drill accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'පවර් ඩිල් උපාංග', // Added
  ),
  'impactdriveraccesories': const TreeNode(
    index: 'impactdriveraccesories',
    available: true,
    isFolder: false,
    children: <String>[], // Corrected from ['']
    data: 'Impact driver accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඉම්පැක්ට් ඩිල් උපාංග', // Added
  ),
  'circulartablemitersaw': const TreeNode(
    index: 'circulartablemitersaw',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Circular, table & miter saw accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රවුම්, මේස සහ මිටර් කියත් උපාංග', // Added
  ),
  'reciprocatingsawandjigsaw': const TreeNode(
    index: 'reciprocatingsawandjigsaw',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Reciprocating Saw and Jig Saw accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඉදිරියට පසුපසට යන කියත් උපාංග', // Added
  ),
  'oscialtingmultitooaccesories': const TreeNode(
    index: 'oscialtingmultitooaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Oscillating multi tool accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'දෝලනය වන බහු මෙවලම් උපාංග ', // Added
  ),
  'rotarytoolaccesories': const TreeNode(
    index: 'rotarytoolaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Rotary tool accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රොටරි මෙවලම් උපාංග', // Added
  ),
  'grinderAccesories': const TreeNode(
    index: 'grinderAccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Grinder accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගයින්ඩර් උපාංග', // Added
  ),
  'sanderaccesories': const TreeNode(
    index: 'sanderaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Sander accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සැන්ඩර් උපාංග ', // Added
  ),
  'routeraccesories': const TreeNode(
    index: 'routeraccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Router accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රවුටර උපාංග', // Added
  ),
  'aircompressotools': const TreeNode(
    index: 'aircompressotools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Aim compressor tools', // Typo in original? Air?
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඒයාර් කම්පෙසර් මෙවලම්', // Added
  ),
  'weldingAccesoroies': const TreeNode(
    index: 'weldingAccesoroies',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Welding accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙල්ඩින් උපාංග', // Added
  ),
  'allpowertoolsaccesories': const TreeNode(
    index: 'allpowertoolsaccesories',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'All power tools accesories',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙනත් විදුලි මෙවලම් උපාංග', // Added
  ),
  'handtools': const TreeNode(
    index: 'handtools',
    available: true,
    isFolder: true,
    children: <String>[
      'cuttingtoolsandpilers',
      'hammersandstrikingtools',
      'handdrillsandgimlets',
      'handsaw',
      'screwdriversandenutdrivers',
      'socketsandwrenches',
      'guns',
      'knifesharpnersandblocks',
      'testers',
      'torches',
      'masonrytools',
      'otherhandandelectricaltools',
    ],
    data: 'Hand tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අත් මෙවලම්', // Added
  ),
  'cuttingtoolsandpilers': const TreeNode(
    index: 'cuttingtoolsandpilers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Cutting tools & Pilers', // Typo in original? Pliers?
    level: 0,
    image: imageUrl,
    sinhalaName: 'කපන ආයුධ සහ අඩු', // Added
  ),
  'hammersandstrikingtools': const TreeNode(
    index: 'hammersandstrikingtools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hammers & Striking tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මිටි සහ කඩන යකඩ', // Added
  ),
  'handdrillsandgimlets': const TreeNode(
    index: 'handdrillsandgimlets',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hand drills, Gimlets & AWLs',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අත් drill සහ උල් අඩු', // Added
  ),
  'handsaw': const TreeNode(
    index: 'handsaw',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Hand saw',
    level: 0,
    image: imageUrl,
    sinhalaName: 'අත් කියත්', // Added
  ),
  'screwdriversandenutdrivers': const TreeNode(
    index: 'screwdriversandenutdrivers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'SCrewdrivers & Nut drivers', // Typo in original? Screwdrivers?
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඉස්කුරුප්පු නියන් සහ නට් නියන්', // Added
  ),
  'socketsandwrenches': const TreeNode(
    index: 'socketsandwrenches',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Socket & Wrenmhes', // Typo in original? Wrenches?
    level: 0,
    image: imageUrl,
    sinhalaName: 'සොකට් සහ යතුර', // Added
  ),
  'guns': const TreeNode(
    index: 'guns',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Guns',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තුවක්කු', // Added
  ),
  'knifesharpnersandblocks': const TreeNode(
    index: 'knifesharpnersandblocks',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Knife sharpners and blocks', // Typo in original? Sharpeners?
    level: 0,
    image: imageUrl,
    sinhalaName: 'පිහි සහ පිහි මදින උපාංග', // Added
  ),
  'otherhandandelectricaltools': const TreeNode(
    index: 'otherhandandelectricaltools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Other hand and masonry tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙනත් විදුලි සහ අත් මෙවලම්', // Added
  ),
  'layoutandmeasuringtools': const TreeNode(
    index: 'layoutandmeasuringtools',
    available: true,
    isFolder: true,
    children: <String>['levels', 'magnerpickuptools'],
    data: 'Layout & Measuring tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මිනුම් මෙවලම්', // Added
  ),
  'levels': const TreeNode(
    index: 'levels',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Levels',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මට්ටම් ලීී', // Added
  ),
  'magnerpickuptools': const TreeNode(
    index: 'magnerpickuptools',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Magnet & Pickup tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'චුම්බක උපකරණ', // Added
  ),
  'torches': const TreeNode(
    index: 'torches',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Torches',
    level: 0,
    image: imageUrl,
    sinhalaName: 'විදුලි පන්දම්', // Added
  ),
  'mainBuilding': const TreeNode(
    index: 'mainBuilding',
    available: true,
    isFolder: true,
    children: <String>['cement', 'sand', 'soil', 'bricks', 'stones'],
    data: 'Building Mateirlas', // Typo in original? Materials?
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/ultra-grip-tile-adhesive-white.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy91bHRyYS1ncmlwLXRpbGUtYWRoZXNpdmUtd2hpdGUuanBnIiwiaWF0IjoxNzQwMjE0NTIwLCJleHAiOjE3NzE3NTA1MjB9.XbCaUtD23mJtjQ_-XY-WD2c4WDzaCNEug8s2u3XuLZI',
    sinhalaName: 'ගොඩනැගිලි ද්‍රව්‍ය', // Added
  ),
  'sand': const TreeNode(
    index: 'sand',
    available: true,
    isFolder:
        true, // Should likely be false if children is empty? Or represent different types of sand? Kept as true based on original.
    children: <String>[],
    data: 'Sand',
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/unwashed-gravel-makes-a-good-base-for-building-projects-1024x683%20(1).jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy91bndhc2hlZC1ncmF2ZWwtbWFrZXMtYS1nb29kLWJhc2UtZm9yLWJ1aWxkaW5nLXByb2plY3RzLTEwMjR4NjgzICgxKS5qcGciLCJpYXQiOjE3NDAyMTQ1MzIsImV4cCI6MTc3MTc1MDUzMn0.c1Tzigxg7RGWn7-KqSGl1Thr1VuucMMQBUWN3k3PaFg',
    sinhalaName: 'වැලි', // Added
  ),
  'soil': const TreeNode(
    index: 'soil',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Soil',
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/white-cement-1kg.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy93aGl0ZS1jZW1lbnQtMWtnLmpwZyIsImlhdCI6MTc0MDIxNDU0MywiZXhwIjoxNzcxNzUwNTQzfQ.licsE1uRJlb7GtI-vf6VOkWZ_xIwbudB3LYSI-rPW-0',
    sinhalaName: 'පස්', // Added
  ),
  'cement': const TreeNode(
    index: 'cement',
    available: true,
    isFolder: true,
    children: <String>['portlandCement', 'coloredCement', 'otherCement'],
    data: 'Cement',
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/output%20(2).jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy9vdXRwdXQgKDIpLmpwZyIsImlhdCI6MTc0MDIxNDU1NiwiZXhwIjoxNzcxNzUwNTU2fQ.5buDC3FaO8aVdfDNZjz7Bj58i6brJImgqNZgrmt6z84',
    sinhalaName: 'සිමෙන්ති', // Added
  ),
  'portlandCement': const TreeNode(
    index: 'portlandCement',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Portland Cement',
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/Peeps-Yellow-Marshmallow-Chicks-2ct_34f451b9-4fc4-4ffa-aae0-e65e7dd968cb.52349faf607a86406cc0ee0cfcca88f6.webp?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy9QZWVwcy1ZZWxsb3ctTWFyc2htYWxsb3ctQ2hpY2tzLTJjdF8zNGY0NTFiOS00ZmM0LTRmZmEtYWFlMC1lNjVlN2RkOTY4Y2IuNTIzNDlmYWY2MDdhODY0MDZjYzBlZTBjZmNjYTg4ZjYud2VicCIsImlhdCI6MTc0MDIxNDU3MiwiZXhwIjoxNzcxNzUwNTcyfQ.HMpqJPhCpVmZPJzQZh75PsXa1a2VquoNrlE-hdA37X0',
    sinhalaName: 'පොර්ට්ලනඩ් සිමෙනති(සාමාන්‍ය සිමෙන්ති)', // Added
  ),
  'coloredCement': const TreeNode(
    index: 'coloredCement',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Colored cement',
    level: 0,
    image:
        'https://yqewezudxihyadvmfovd.supabase.co/storage/v1/object/sign/products/Keurig-K-Classic-Single-Serve-K-Cup-Pod-Coffee-Maker-Black_23e58041-372d-451f-b8ba-828fd79db877.0e47c3dc1a46e71bbbf8803ff3ed1ce6.webp?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0cy9LZXVyaWctSy1DbGFzc2ljLVNpbmdsZS1TZXJ2ZS1LLUN1cC1Qb2QtQ29mZmVlLU1ha2VyLUJsYWNrXzIzZTU4MDQxLTM3MmQtNDUxZi1iOGJhLTgyOGZkNzlkYjg3Ny4wZTQ3YzNkYzFhNDZlNzFiYmJmODgwM2ZmM2VkMWNlNi53ZWJwIiwiaWF0IjoxNzQwMjE0NjU4LCJleHAiOjE3NzE3NTA2NTh9.fqK0cJ-FssykJdgPXN7VVpwbChLKId0hZxnCR0AXY4w',
    sinhalaName: 'පාට සිමෙන්ති', // Added
  ),
  'otherCement': const TreeNode(
    index: 'otherCement',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Other cement',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙනත් සිමෙන්ති', // Added
  ),
  'bricks': const TreeNode(
    index: 'bricks',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Bricks',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගඩොල්', // Added
  ),
  'stones': const TreeNode(
    index: 'stones',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Stones',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ගල්', // Added
  ),
  'mainPaint': const TreeNode(
    index: 'mainPaint',
    available: true,
    isFolder: true,
    children: <String>['paintList', 'paintTools', 'paintaccesories', 'adhesiveandtapes'],
    data: 'Paint',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත', // Added
  ),
  'paintList': const TreeNode(
    index: 'paintList',
    available: true,
    isFolder: true,
    children: <String>[
      'emulsion',
      'enamel',
      'weathercoat',
      'floorcoat',
      'colorvarnish',
      'kemikote',
      'nontoxic',
      'woodstain',
      'sandingsealer',
      'roofingpaint',
    ],
    data: 'Paint List',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත වර්ග', // Added
  ),
  'emulsion': const TreeNode(
    index: 'emulsion',
    available: true,
    isFolder: true,
    children: <String>[],
    data: 'Emulsion',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඉමල්ෂන්', // Added
  ),

  'enamel': const TreeNode(
    index: 'bormawatches',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Enamel',
    level: 0,
    image: imageUrl,
    sinhalaName: 'එනමල්', // Added
  ),
  'weathercoat': const TreeNode(
    index: 'jchem',
    available: true,
    isFolder: true,
    children: <String>['ncproducts', 'decorativepaint'],
    data: 'Weathercoat',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෙදර් කෝට්', // Added
  ),
  'floorcoat': const TreeNode(
    index: 'floorcoat',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Floor coat',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ෆ්ලෝර් කෝට්', // Added
  ),
  'colorvarnish': const TreeNode(
    index: 'colorvarnish',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Color Varnish',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කලර් වර්නිෂ්', // Added
  ),
  'kemikote': const TreeNode(
    index: 'kemikote',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Kemikote',
    level: 0,
    image: imageUrl,
    sinhalaName: 'කෙමි කෝට්', // Added
  ),
  'nontoxic': const TreeNode(
    index: 'nontoxic',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Non toxic',
    level: 0,
    image: imageUrl,
    sinhalaName: 'නන් ටොක්සික්', // Added
  ),
  'woodstain': const TreeNode(
    index: 'woodstain',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Wood stain',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වෘඩ් ස්ටේන්', // Added
  ),
  'sandingsealer': const TreeNode(
    index: 'sandingsealer',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Sanding sealer',
    level: 0,
    image: imageUrl,
    sinhalaName: 'සැන්ඩින්ග් සීලර්', // Added
  ),
  'roofingpaint': const TreeNode(
    index: 'roofingpaint',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Roofing paint',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රෑෆින්ග් පෙන්ට්පෙන්ට්', // Added
  ),
  'paintTools': const TreeNode(
    index: 'paintTools',
    available: true,
    isFolder: true,
    children: <String>['brushesandrollers', 'maskingtape', 'sandpaper', 'sprayguns', 'ladders'],
    data: 'Paint Tools',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත උපාංග', // Added
  ),
  'brushesandrollers': const TreeNode(
    index: 'brushesandrollers',
    available: true,
    isFolder: true,
    children: <String>['brushes', 'rollers'],
    data: 'Brushes & Rollers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත බුරුසු සහ රෝලර්ස්', // Added
  ),
  'brushes': const TreeNode(
    index: 'brushes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Brushes',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත බුරුසු', // Added
  ),
  'rollers': const TreeNode(
    index: 'rollers',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Rollers',
    level: 0,
    image: imageUrl,
    sinhalaName: 'රෝලර්ස්', // Added
  ),
  'maskingtape': const TreeNode(
    index: 'maskingtape',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Masking tape',
    level: 0,
    image: imageUrl,
    sinhalaName: 'මාස්කින්ග් ටේප්', // Added
  ),
  'sandpaper': const TreeNode(
    index: 'sandpaper',
    available: false, // Note: Available is false here
    isFolder: false,
    children: <String>[],
    data: 'Sandpaper',
    level: 0,
    image: imageUrl,
    sinhalaName: 'වැලි කොළ', // Added
  ),
  'sprayguns': const TreeNode(
    index: 'sprayguns',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Spray guns',
    level: 0,
    image: imageUrl,
    sinhalaName: 'තීන්ත gun', // Added
  ),

  'ladders': const TreeNode(
    index: 'ladders',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Ladders',
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඉනි මග', // Added
  ),
  'adhesiveandtapes': const TreeNode(
    index: 'adhesiveandtapes',
    available: true,
    isFolder: false,
    children: <String>[],
    data: 'Adhesive and paints', // Typo in original? Should be Tapes? Kept original.
    level: 0,
    image: imageUrl,
    sinhalaName: 'ඇලවුම්', // Added
  ),
};
