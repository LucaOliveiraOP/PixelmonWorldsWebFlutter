class StoreItem {
  final String name;
  final double price;
  final String image;
  final List<String> itemTypes;

  StoreItem({
    required this.name,
    required this.price,
    required this.image,
    required this.itemTypes,
  });

  static List<StoreItem> allItems = [
    // StoreItem(
    //   name: 'Chave Texturas - Darkmoth',
    //   price: 12.99,
    //   image: 'assets/darkmoth.png',
    //   itemTypes: ['chaves'],
    // ),
    // StoreItem(
    //   name: 'GiftCard R\$ 30',
    //   price: 30.00,
    //   image: 'assets/giftcard30.png',
    //   itemTypes: ['giftcard'],
    // ),
    // StoreItem(
    //   name: 'GiftCard R\$ 100',
    //   price: 100.00,
    //   image: 'assets/giftcard100.png',
    //   itemTypes: ['giftcard'],
    // ),
    StoreItem(
      name: 'VIP Ace (30D)',
      price: 14.99,
      image: 'assets/vip_ace.png',
      itemTypes: ['vip'],
    ),
    StoreItem(
      name: 'VIP Elite (30D)',
      price: 29.99,
      image: 'assets/vip_elite.png',
      itemTypes: ['vip', 'destaque'],
    ),
    StoreItem(
      name: 'VIP Master (30D)',
      price: 49.99,
      image: 'assets/vip_master.png',
      itemTypes: ['vip', 'destaque'],
    ),
    StoreItem(
      name: 'VIP Omega (45D)',
      price: 89.99,
      image: 'assets/vip_omega.png',
      itemTypes: ['vip', 'destaque'],
    ),
    StoreItem(
      name: 'VIP Guardian (75D)',
      price: 189.99,
      image: 'assets/vip_guardian.png',
      itemTypes: ['vip', 'destaque'],
    ),
    StoreItem(
      name: 'VIP Legendary (∞)',
      price: 449.99,
      image: 'assets/vip_legend.png',
      itemTypes: ['vip', 'destaque'],
    ),
    StoreItem(
      name: 'VIP Ultimate (∞)',
      price: 599.99,
      image: 'assets/vip_ultimate.png',
      itemTypes: ['vip', 'destaque'],
    ),
    // StoreItem(
    //   name: '400x PokéFichas',
    //   price: 33.60,
    //   image: 'assets/pokefichas.png',
    //   itemTypes: ['fichas', 'destaque'],
    // ),
    // StoreItem(
    //   name: 'Chave Texturas - Eclipse',
    //   price: 12.99,
    //   image: 'assets/eclipse.png',
    //   itemTypes: ['chaves'],
    // ),
    // StoreItem(
    //   name: 'Chave Texturas - Sonho Cósmico',
    //   price: 19.99,
    //   image: 'assets/sonhocosmico.png',
    //   itemTypes: ['chaves', 'destaque'],
    // ),
  ];
}
