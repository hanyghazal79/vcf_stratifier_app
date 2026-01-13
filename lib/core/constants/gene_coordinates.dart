class GeneCoordinates {
  static const Map<String, Map<String, dynamic>> breastCancerGenes = {
    'BRCA1': {'chr': '17', 'start': 43044295, 'end': 43125483, 'risk': 'high'},
    'BRCA2': {'chr': '13', 'start': 32889611, 'end': 32973805, 'risk': 'high'},
    'PALB2': {'chr': '16', 'start': 23614479, 'end': 23652679, 'risk': 'high'},
    'TP53': {'chr': '17', 'start': 7661779, 'end': 7687550, 'risk': 'high'},
    'PTEN': {'chr': '10', 'start': 89622870, 'end': 89731687, 'risk': 'high'},
    'CHEK2': {
      'chr': '22',
      'start': 28687741,
      'end': 28741829,
      'risk': 'moderate',
    },
    'ATM': {
      'chr': '11',
      'start': 108093099,
      'end': 108239829,
      'risk': 'moderate',
    },
    'CDH1': {
      'chr': '16',
      'start': 68737224,
      'end': 68835537,
      'risk': 'moderate',
    },
    'STK11': {
      'chr': '19',
      'start': 1222203,
      'end': 1249790,
      'risk': 'moderate',
    },
    'NF1': {
      'chr': '17',
      'start': 29421945,
      'end': 29704695,
      'risk': 'moderate',
    },
    'BRIP1': {
      'chr': '17',
      'start': 61679390,
      'end': 61863772,
      'risk': 'moderate',
    },
    'RAD51C': {
      'chr': '17',
      'start': 58691164,
      'end': 58734795,
      'risk': 'moderate',
    },
    'RAD51D': {
      'chr': '17',
      'start': 35082916,
      'end': 35139936,
      'risk': 'moderate',
    },
    'BARD1': {
      'chr': '2',
      'start': 214728115,
      'end': 214826885,
      'risk': 'moderate',
    },
    'NBN': {'chr': '8', 'start': 89933043, 'end': 90004695, 'risk': 'moderate'},
  };

  static bool isHighRiskGene(String gene) {
    return breastCancerGenes[gene]?['risk'] == 'high';
  }

  static List<String> getHighRiskGenes() {
    return breastCancerGenes.entries
        .where((entry) => entry.value['risk'] == 'high')
        .map((entry) => entry.key)
        .toList();
  }

  static List<String> getAllGenes() {
    return breastCancerGenes.keys.toList();
  }
}
