// 文章データ
import UIKit

class SentenceViewController: UITabBarController {

    // Beginner Page
    var sentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["你早","下午好","晚上好","再见","明天见","下周见","回头见","你好吗？","谢谢","对不起"].map{Contact(name: $0, hasFavorited: false)})
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
    
    // Intermediate Page
    var  IntermediateSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["我","你","他","她","我们","他们","她们","这","这些","那","那些"].map{Contact(name: $0, hasFavorited: false)})
    ]
    var IntermediateSentence = ["我","你","他","她","我们","他们","她们","这","这些","那","那些"]
    
    var IntermediatePronunciation = ["wǒ","nǐ","tā","tā","wǒmen","tāmen","tāmen","zhè","zhèxiē","nà","nàxiē"]
    
    var IntermediateEnglish = [
        NSLocalizedString("I", comment: ""),
        NSLocalizedString("you", comment: ""),
        NSLocalizedString("he", comment: ""),
        NSLocalizedString("she", comment: ""),
        NSLocalizedString("we", comment: ""),
        NSLocalizedString("they (male)", comment: ""),
        NSLocalizedString("they (female)", comment: ""),
        NSLocalizedString("this", comment: ""),
        NSLocalizedString("these", comment: ""),
        NSLocalizedString("that", comment: ""),
        NSLocalizedString("those", comment: "")
    ]
    
    // Advanced Page
    var  AdvancedSentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["你叫什么名字","他是谁？","它需要多长时间","你喜欢什么类型的电影","在哪里完成","什么时候完成","你为什么喜欢这部电影","现在是几奌","你家有几口人","你想去看电影吗"].map{Contact(name: $0, hasFavorited: false)})
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
        ExpandableNames(isExpanded: true, names:  ["谢谢", "不好意思", "对不起","我要check in", "能不能帮我保管行李？", "我想知道Wi-Fi的密码", "点菜", "买单", "多少钱", "请再说一遍"].map{Contact(name: $0, hasFavorited: false)})
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
        ].map { Contact(name: $0, hasFavorited: false) })
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
        ].map { Contact(name: $0, hasFavorited: false) })
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

