class PrivacyPolicyData {
  final String title;
  final String content;

  PrivacyPolicyData({required this.title, required this.content});
}

List<PrivacyPolicyData> privacyPolicyData = [
  PrivacyPolicyData(
    title: 'Политика конфиденциальности',
    content:
        'Настоящая Политика конфиденциальности описывает, как Uide собирает, использует и защищает персональную информацию, которую вы предоставляете при использовании нашего приложения.',
  ),
  PrivacyPolicyData(
    title: 'Собираемая информация',
    content:
        'Мы собираем следующие типы персональной информации:\n\n- Имя, адрес электронной почты и контактная информация.\n- Местоположение и предпочтения для поиска соседа по комнате и жилья.',
  ),
  PrivacyPolicyData(
    title: 'Использование информации',
    content:
        'Мы можем использовать вашу персональную информацию для следующих целей:\n\n- Подбор потенциальных соседей или вариантов жилья.\n- Взаимодействие с вами в отношении ваших запросов и обращений.',
  ),
  PrivacyPolicyData(
    title: 'Обмен информацией',
    content:
        'Мы можем передавать вашу персональную информацию следующим лицам:\n\n- Владельцам недвижимости и потенциальным соседям для целей подбора.\n- Поставщикам услуг, которые помогают нам в работе нашего приложения.',
  ),
  PrivacyPolicyData(
    title: 'Безопасность данных',
    content:
        'Мы принимаем разумные меры для защиты вашей персональной информации от несанкционированного доступа или раскрытия.',
  ),
  PrivacyPolicyData(
    title: 'Свяжитесь с нами',
    content:
        'Если у вас возникли вопросы или проблемы с нашей Политикой конфиденциальности, пожалуйста, свяжитесь с нами по адресу privacy@uide.com.',
  ),
];
