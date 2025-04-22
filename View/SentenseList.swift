// 文章データ
import UIKit

class SentenseList {

    //MARK: - Greetings
    var sentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["你早","下午好","晚上好","再见","明天见","下周见","回头见","你好吗？","谢谢","对不起"].map{Contact(name: $0,
            hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)})
    ]
    var sentence = ["你早","下午好","晚上好","再见","明天见","下周见","回头见","你好吗？","谢谢","对不起"]
    
    var Pronunciation = ["Nǐzǎo","Xiàwǔ hǎo.","Wǎnshang hǎo","Zàijiàn","Míngtiān jiàn","Xiàzhōu jiàn","Huítou jiàn","Nǐ hǎo ma?","Xièxie","duìbuqǐ"]
    
    var english = [
        NSLocalizedString("Good moring", comment: ""),
        NSLocalizedString("Good afternoon", comment: ""),
        NSLocalizedString("Good evening", comment: ""),
        NSLocalizedString("Goodbye", comment: ""),
        NSLocalizedString("See you tomorrow", comment: ""),
        NSLocalizedString("See you next week", comment: ""),
        NSLocalizedString("See you later", comment: ""),
        NSLocalizedString("How are you?", comment: ""),
        NSLocalizedString("Thank you", comment: ""),
        NSLocalizedString("Sorry", comment: "")
    ]
    
    //MARK: - Pronouns
    // 人称代名詞（Personal Pronouns）
    var personalPronounsSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "我", "你", "他", "她", "它","我们", "你们", "他们", "她们", "它们"
        ].map { Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false) })
    ]
    var personalPronounsSentence = ["我", "你", "他", "她", "它", "我们", "你们", "他们", "她们", "它们"]
    var personalPronounsPronunciation = ["wǒ", "nǐ", "tā", "tā", "tā", "wǒmen", "nǐmen", "tāmen", "tāmen", "tāmen"]
    var personalPronounsEnglish = [
        NSLocalizedString("I", comment: ""),
        NSLocalizedString("you", comment: ""),
        NSLocalizedString("he", comment: ""),
        NSLocalizedString("she", comment: ""),
        NSLocalizedString("it", comment: ""),
        NSLocalizedString("we", comment: ""),
        NSLocalizedString("you (plural)", comment: ""),
        NSLocalizedString("they (male)", comment: ""),
        NSLocalizedString("they (female)", comment: ""),
        NSLocalizedString("they (neuter)", comment: "")
    ]

    // 指示代名詞（Demonstrative Pronouns）
    var demonstrativePronounsSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["这", "这些", "那", "那些"
        ].map { Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false) })
    ]
    var demonstrativePronounsSentence = ["这", "这些", "那", "那些"]
    var demonstrativePronounsPronunciation = ["zhè", "zhèxiē", "nà", "nàxiē"]
    var demonstrativePronounsEnglish = [
        NSLocalizedString("this", comment: ""),
        NSLocalizedString("these", comment: ""),
        NSLocalizedString("that", comment: ""),
        NSLocalizedString("those", comment: "")
    ]

    // 疑問代名詞（Interrogative Pronouns）
    var interrogativePronounsSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "谁", "什么", "哪", "哪些", "什么时候", "哪里", "为什么", "怎么", "多少"
        ].map { Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false) })
    ]

    var interrogativePronounsSentence = ["谁", "什么", "哪", "哪些", "什么时候", "哪里", "为什么", "怎么", "多少"]
    var interrogativePronounsPronunciation = ["shéi", "shénme", "nǎ", "nǎxiē", "shénme shíhou", "nǎlǐ", "wèishénme", "zěnme", "duōshǎo"]
    var interrogativePronounsEnglish = [
        NSLocalizedString("who", comment: ""),
        NSLocalizedString("what", comment: ""),
        NSLocalizedString("which", comment: ""),
        NSLocalizedString("which ones", comment: ""),
        NSLocalizedString("when", comment: ""),
        NSLocalizedString("where", comment: ""),
        NSLocalizedString("why", comment: ""),
        NSLocalizedString("how", comment: ""),
        NSLocalizedString("how many", comment: "")
    ]


    
    // Advanced Page
    var  AdvancedSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["你叫什么名字","他是谁？","它需要多长时间","你喜欢什么类型的电影","在哪里完成","什么时候完成","你为什么喜欢这部电影","现在是几奌","你家有几口人","你想去看电影吗"].map{Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)})
    ]
    var AdvancedSentence = ["你叫什么名字","他是谁？","它需要多长时间","你喜欢什么类型的电影","在哪里完成","什么时候完成","你为什么喜欢这部电影","现在是几奌","你家有几口人","你想去看电影吗"]
    
    var AdvancedPronunciation = ["Nǐ jiào shénme míngzi","tā shì shéi?","Tā xūyào duō cháng shíjiān","Nǐ xǐhuān shénme lèixíng de diànyǐng","Zài nǎlǐ wánchéng","Shénme shíhòu wánchéng","Nǐ wèishéme xǐhuān zhè bù diànyǐng","Xiànzài shì jǐ diǎn","Nǐ jiā yǒu jǐkǒu rén?","Nǐ xiǎng qù kàn diànyǐng ma"]
    
    var AdvancedEnglish = [
        NSLocalizedString("What's your name?", comment: ""),
        NSLocalizedString("Who is he?", comment: ""),
        NSLocalizedString("How long does it take?", comment: ""),
        NSLocalizedString("What type of movies do you like?", comment: ""),
        NSLocalizedString("Where will it be done?", comment: ""),
        NSLocalizedString("When will it be done?", comment: ""),
        NSLocalizedString("Why do you like this movie?", comment: ""),
        NSLocalizedString("What time is it?", comment: ""),
        NSLocalizedString("How many people are in your family?", comment: ""),
        NSLocalizedString("Do you want to go see a movie?", comment: "")
    ]
    
    // Traveler Page
    var tripSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["谢谢", "不好意思", "对不起","我要check in", "能不能帮我保管行李？", "我想知道Wi-Fi的密码", "点菜", "买单", "多少钱", "请再说一遍"].map{Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)})
    ]
    
    var tripSentence = [
        "谢谢", "不好意思","对不起","我要check in", "能不能帮我保管行李？", "我想知道Wi-Fi的密码", "点菜", "买单", "多少钱", "请再说一遍"
    ];

    var tripPronunciation = [
        "Xièxiè", "bù hǎo yì sī","duìbuqǐ","Wǒ yào check in", "Néng bùnéng bāng wǒ bǎoguǎn xínglǐ?", "Wǒ xiǎng zhīdào Wi-Fi de mìmǎ",
        "Diǎn cài", "Mǎidān", "Duōshǎo qián", "Qǐng zàishuō yībiàn"
    ];

    var tripEnglish = [
        NSLocalizedString("Thank you", comment: ""),
        NSLocalizedString("Excuse me", comment: ""),
        NSLocalizedString("Sorry", comment: ""),
        NSLocalizedString("I want to check in", comment: ""),
        NSLocalizedString("Can you help me store my luggage?", comment: ""),
        NSLocalizedString("What’s the Wi-Fi password?", comment: ""),
        NSLocalizedString("I would like to order", comment: ""),
        NSLocalizedString("Bill, please", comment: ""),
        NSLocalizedString("How much is it?", comment: ""),
        NSLocalizedString("Can you say it again?", comment: "")
    ];
    
    // Drama Page
    var dramaSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "真的吗？", "我懂了", "没关系", "加油", "不要紧",
            "放松", "真是的", "怎么了？", "别这样", "随便"
        ].map { Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false) })
    ]

    var dramaSentence = [
        "真的吗？", "我懂了", "没关系", "加油", "不要紧",
        "放松", "真是的", "怎么了？", "别这样", "随便"
    ];
    var dramaPronunciation = [
        "Zhēn de ma?", "Wǒ dǒng le", "Méi guānxi", "Jiā yóu", "Bù yàojǐn",
        "Fàngsōng", "Zhēn shì de", "Zěn me le?", "Bié zhèyàng", "Suíbiàn"
    ];
    var dramaEnglish = [
        NSLocalizedString("Really?", comment: ""),
        NSLocalizedString("I understand", comment: ""),
        NSLocalizedString("It's okay", comment: ""),
        NSLocalizedString("Good luck", comment: ""),
        NSLocalizedString("It's fine", comment: ""),
        NSLocalizedString("Relax", comment: ""),
        NSLocalizedString("Really?", comment: ""),
        NSLocalizedString("What’s wrong?", comment: ""),
        NSLocalizedString("Don’t do that", comment: ""),
        NSLocalizedString("Whatever", comment: "")
    ];
    
    // Restaurant Page
    var restaurantSentenceArray = [
        ExpandableNames(isExpanded: true, names: [
            "我有预订", "没有预约，有位子吗？", "请给我菜单", "有什么推荐的吗？", "这个菜辣吗？",
            "有没有素食的菜？", "请给我一杯水", "请稍等", "可以打包吗？", "很好吃！"
        ].map { Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false) })
    ]

    var restaurantSentence = [
        "我有预订",
        "没有预约，有位子吗？",
        "请给我菜单",
        "有什么推荐的吗？",
        "这个菜辣吗？",
        "有没有素食的菜？",
        "请给我一杯水",
        "请稍等",
        "可以打包吗？",
        "很好吃！"
    ];

    var restaurantPronunciation = [
        "Wǒ yǒu yùdìng",
        "Méiyǒu yùyuē, yǒu wèizi ma?",
        "Qǐng gěi wǒ càidān",
        "Yǒu shé me tuījiàn de ma?",
        "Zhège cài là ma?",
        "Yǒu méiyǒu sùshí de cài?",
        "Qǐng gěi wǒ yī bēi shuǐ",
        "Qǐng shāoděng",
        "Kěyǐ dǎbāo ma?",
        "Hěn hǎochī!"
    ];

    var restaurantEnglish = [
        NSLocalizedString("I have a reservation", comment: ""),
        NSLocalizedString("No reservation, is there a table?", comment: ""),
        NSLocalizedString("Please give me the menu", comment: ""),
        NSLocalizedString("What do you recommend?", comment: ""),
        NSLocalizedString("Is this dish spicy?", comment: ""),
        NSLocalizedString("Do you have vegetarian dishes?", comment: ""),
        NSLocalizedString("Please give me a glass of water", comment: ""),
        NSLocalizedString("Please wait a moment", comment: ""),
        NSLocalizedString("Can I take this to go?", comment: ""),
        NSLocalizedString("It’s very delicious!", comment: "")
    ];
    
    //MARK: - Shopping
    var shoppingSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["这个多少钱？","有没有别的颜色？","可以试穿吗？","我想买这个","可以刷卡吗？"].map{
            Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var shoppingSentence = ["这个多少钱？","有没有别的颜色？","可以试穿吗？","我想买这个","可以刷卡吗？"]
    var shoppingPronunciation = ["Zhège duōshǎo qián?","Yǒu méiyǒu bié de yánsè?","Kěyǐ shìchuān ma?","Wǒ xiǎng mǎi zhège","Kěyǐ shuākǎ ma?"]
    var shoppingEnglish = [
        NSLocalizedString("How much is this?", comment: ""),
        NSLocalizedString("Do you have other colors?", comment: ""),
        NSLocalizedString("Can I try it on?", comment: ""),
        NSLocalizedString("I want to buy this", comment: ""),
        NSLocalizedString("Can I pay by card?", comment: "")
    ]

    //MARK: - Phone and Message
    var phoneSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["喂，你好","请问是谁？","稍等一下","我再打给你","我发给你"].map{
            Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var phoneSentence = ["喂，你好","请问是谁？","稍等一下","我再打给你","我发给你"]
    var phonePronunciation = ["Wéi, nǐ hǎo","Qǐngwèn shì shéi?","Shāoděng yíxià","Wǒ zài dǎ gěi nǐ","Wǒ fā gěi nǐ"]
    var phoneEnglish = [
        NSLocalizedString("Hello on the phone", comment: ""),
        NSLocalizedString("May I ask who's calling?", comment: ""),
        NSLocalizedString("Hold on a moment", comment: ""),
        NSLocalizedString("I'll call you back", comment: ""),
        NSLocalizedString("I’ll send it to you", comment: "")
    ]

    //MARK: - Weather and Season
    var weatherSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["今天天气很好","今天下雨了","外面很冷","夏天快到了","冬天很冷"].map{
            Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var weatherSentence = ["今天天气很好","今天下雨了","外面很冷","夏天快到了","冬天很冷"]
    var weatherPronunciation = ["Jīntiān tiānqì hěn hǎo","Jīntiān xiàyǔ le","Wàimiàn hěn lěng","Xiàtiān kuài dàole","Dōngtiān hěn lěng"]
    var weatherEnglish = [
        NSLocalizedString("The weather is nice today", comment: ""),
        NSLocalizedString("It's raining today", comment: ""),
        NSLocalizedString("It's cold outside", comment: ""),
        NSLocalizedString("Summer is coming", comment: ""),
        NSLocalizedString("Winter is cold", comment: "")
    ]

    //MARK: - Health and Hospital
    var healthSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["我头疼","我发烧了","需要看医生","有药吗？","请帮我叫救护车"].map{
            Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var healthSentence = ["我头疼","我发烧了","需要看医生","有药吗？","请帮我叫救护车"]
    var healthPronunciation = ["Wǒ tóuténg","Wǒ fāshāo le","Xūyào kàn yīshēng","Yǒu yào ma?","Qǐng bāng wǒ jiào jiùhùchē"]
    var healthEnglish = [
        NSLocalizedString("I have a headache", comment: ""),
        NSLocalizedString("I have a fever", comment: ""),
        NSLocalizedString("Need to see a doctor", comment: ""),
        NSLocalizedString("Do you have medicine?", comment: ""),
        NSLocalizedString("Please call an ambulance", comment: "")
    ]

    //MARK: - Business
    var businessSentenceArray = [
        ExpandableNames(isExpanded: true, names: ["请问，您方便吗？","我明天再联系您","很高兴认识您","请确认一下","麻烦您了"].map{
            Contact(name: $0, hasFavorited: false, hasFavorited2: false, hasFavorited3: false, hasFavorited4: false)
        })
    ]
    var businessSentence = ["请问，您方便吗？","我明天再联系您","很高兴认识您","请确认一下","麻烦您了"]
    var businessPronunciation = ["Qǐngwèn, nín fāngbiàn ma?","Wǒ míngtiān zài liánxì nín","Hěn gāoxìng rènshi nín","Qǐng quèrèn yíxià","Máfan nín le"]
    var businessEnglish = [
        NSLocalizedString("May I ask, is it convenient for you?", comment: ""),
        NSLocalizedString("I’ll contact you again tomorrow", comment: ""),
        NSLocalizedString("Nice to meet you (formal)", comment: ""),
        NSLocalizedString("Please confirm", comment: ""),
        NSLocalizedString("Sorry for the trouble", comment: "")
    ]


}

