// 文章データ
import UIKit

class SentenceViewController: UITabBarController {

    
    var sentenceArray = [
        ExpandableNames(isExpanded: true, names:  ["你早","下午好","晚上好","再见","明天见","下周见","回头见","你好吗？","谢谢","对不起"].map{Contact(name: $0, hasFavorited: false)})
    ]
    var sentence = ["你早","下午好","晚上好","再见","明天见","下周见","回头见","你好吗？","谢谢","对不起"]
    
    var Pronunciation = ["Nǐzǎo","Xiàwǔ hǎo.","Wǎnshang hǎo","Zàijiàn","Míngtiān jiàn","Xiàzhōu jiàn","Huítou jiàn","Nǐ hǎo ma?","Xièxie","duìbuqǐ",]
    
    var japanese = ["おはよう","こんにちは","こんばんは","さようなら","また明日","また来週","またあとで","お元気ですか？","ありがとう","ごめんなさい",]
    
    
    var IntermediateSentence = ["我","你","他","她","我们","他们","她们","这","这些","那","那些"]
    
    var IntermediatePronunciation = ["wǒ","nǐ","tā","tā","wǒmen","tāmen","tāmen","zhè","zhèxiē","nà","nàxiē"]
    
    var IntermediateJananase = ["わたし","あなた","彼","女性","わたしたち","彼ら","彼女たち","これ","これら","それ","それら"]
    
    
    var AdvancedSentence = ["你叫什么名字","他是谁？","它需要多长时间","你喜欢什么类型的电影","在哪里完成","什么时候完成","你为什么喜欢这部电影","现在是几奌","你家有几口人","你想去看电影吗"]
    
    var AdvancedPronunciation = ["Nǐ jiào shénme míngzi","tā shì shéi?","Tā xūyào duō cháng shíjiān","Nǐ xǐhuān shénme lèixíng de diànyǐng","Zài nǎlǐ wánchéng","Shénme shíhòu wánchéng","Nǐ wèishéme xǐhuān zhè bù diànyǐng","Xiànzài shì jǐ diǎn","Nǐ jiā yǒu jǐkǒu rén?","Nǐ xiǎng qù kàn diànyǐng ma"]
    
    var AdvancedJananase = ["お名前は何ですか","彼はどなたですか？","どのくらい時間がかかりますか","どんな映画が好きですか","どこで行われますか","いつ行われますか","なぜその映画が好きですか","今何時ですか","あなたの家は何人家族ですか?","映画を見に行きませんか"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
