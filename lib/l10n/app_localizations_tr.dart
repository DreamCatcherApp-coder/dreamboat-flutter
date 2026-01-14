// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get homeTitle => 'DreamBoat';

  @override
  String get homeSubtitle => 'Rüya Dünyanızda Bir Yolculuğa Çıkın';

  @override
  String get homeNewDream => 'Yeni Rüya Ekle';

  @override
  String get homeJournal => 'Rüya Günlüğüm';

  @override
  String get homeStats => 'Rüya Dünyam';

  @override
  String get homeGuide => 'Lucid Rüya Rehberi';

  @override
  String get homeSettings => 'Ayarlar';

  @override
  String get statsTitle => 'Rüya Dünyam';

  @override
  String get statsTipTitle => 'Günün Rüya Tavsiyesi';

  @override
  String get statsTipContent =>
      'Bugün, içsel yolculuğunu derinleştirmek için bir anı defteri tutmayı deneyebilirsin. Rüyalarında gördüğün çocukluk hâlinle bağ kurarak, o saf sevgiyi yeniden keşfetmek için birkaç dakikanı ayır ve hislerini kaleme al.';

  @override
  String get statsAnalysisTitle => 'Bu Ayın Duygu Dağılımı';

  @override
  String get statsAnalysisResult => 'Rüya Desen Analizi';

  @override
  String get statsAnalyzeBtn => 'Rüya Desenini Gör';

  @override
  String get statsAnalysisIntroTitle => 'Rüya Desen Analizi';

  @override
  String get statsAnalysisIntroContent =>
      'Rüya Desen Analizi, haftalık olarak kaydettiğin rüyaları bir arada inceleyerek bilinçaltının tekrar eden temalarını, duygusal döngülerini ve sembolik eğilimlerini ortaya çıkarır. Bu sistem, tek tek rüya yorumlarından farklı olarak zaman içinde oluşan kalıpları, yani zihninin sana anlatmaya çalıştığı büyük resmi gösterir.';

  @override
  String statsAnalysisWait(Object days) {
    return 'Yeni analiz için $days gün beklemelisiniz.';
  }

  @override
  String get statsAnalysisMinDreams => 'En Az 5 Kaydedilmiş Rüya Gerekir';

  @override
  String get statsAnalysisDone => 'Haftalık Analiz Yapıldı';

  @override
  String get statsAnalyzing => 'Analiz Ediliyor...';

  @override
  String get statsOffline => 'İnternet gerekli';

  @override
  String get statsNoData => 'Yeterli veri yok';

  @override
  String get statsProcessing =>
      'Rüya Deseniniz hazırlanıyor,\nlütfen kısa bir süre bekleyiniz.';

  @override
  String get guideTitle => 'Lucid Rüya Rehberi';

  @override
  String get guideIntroTitle => 'Lucid Rüya Nedir?';

  @override
  String get guideIntroContent =>
      'Lucid rüya (bilinçli rüya), rüyada olduğunun farkına vardığın ve rüyanı kontrol edebildiğin eşsiz bir deneyimdir.';

  @override
  String get moodLove => 'Aşk';

  @override
  String get moodHappy => 'Mutluluk';

  @override
  String get moodSad => 'Üzüntü';

  @override
  String get moodScared => 'Korku';

  @override
  String get moodAnger => 'Öfke';

  @override
  String get moodNeutral => 'Nötr';

  @override
  String get newDreamModalTitle => 'Bu Rüyada Hangi Duygu\nHakimdi?';

  @override
  String get close => 'Kapat';

  @override
  String get journalTitle => 'Rüya Günlüğüm';

  @override
  String get journalAll => 'Tümü';

  @override
  String get journalFavorites => 'Favorilerim';

  @override
  String get journalNoDreams => 'Henüz kaydedilmiş rüya yok.';

  @override
  String get journalNoFavorites => 'Henüz favori rüya yok.';

  @override
  String get journalAnalysis => 'Rüya Yorumu';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsPrivacy => 'Gizlilik Politikası';

  @override
  String get settingsSupport => 'Destek';

  @override
  String get settingsVersion => 'Sürüm 1.0.0';

  @override
  String get settingsNotifOpen => 'Bildirimleri Aç';

  @override
  String get settingsNotifTime => 'Günlük Hatırlatıcı';

  @override
  String get settingsNotifDesc =>
      'Her sabah rüyalarını kaydetmen için nazik bir hatırlatma al.';

  @override
  String get settingsPrivacyTitle => 'Gizlilik Politikası';

  @override
  String get settingsSupportTitle => 'Destek';

  @override
  String get settingsAppStatus => 'Uygulama Durumu';

  @override
  String get settingsSupportDesc => 'Bir sorun mu var? Bize ulaşın!';

  @override
  String get settingsSend => 'Mesaj Gönder';

  @override
  String get settingsSending => 'Mesaj gönderildi!';

  @override
  String get newDreamMinCharHint =>
      'Rüyanın yorumlanabilmesi için minimum 50 karakter girmelisin.';

  @override
  String get homeSpecialBadge => 'PRO';

  @override
  String get newDreamTitle => 'Yeni Rüya';

  @override
  String get newDreamSubtitle => 'Rüyalarını her gün kaydetmeyi unutma...';

  @override
  String get newDreamSave => 'Rüyamı Kaydet ve Yorumla';

  @override
  String get newDreamPlaceholderDetail =>
      'Rüyanı buraya detaylandır...\n\nÖrnek: Çiçeklerle dolu sakin bir bahçede yürüyordum. Güneş yaprakların arasından yumuşak bir ışık yayıyordu. Yakındaki küçük bir kuş havuzunda su hafifçe dalgalanıyordu.';

  @override
  String get newDreamPlaceholder => 'Rüyanı buraya detaylandır...';

  @override
  String get guideCompletionTitle => 'Tebrikler!';

  @override
  String get guideCompletionContent =>
      'Lucid Rüya Rehberinin tüm aşamalarını tamamladın.';

  @override
  String get guideStage1Title =>
      '1. MILD Tekniği (Mnemonic Induction of Lucid Dreams)';

  @override
  String get guideStage1Subtitle => 'Rüyalarınıza uyanış tohumunu ekmek';

  @override
  String get guideStage1Content =>
      'Lucid dreaming yolculuğunun başlangıç noktasıdır. MILD, yani \"Mnemonic Induction of Lucid Dreams\", uykuya dalmadan önce bilinçaltına net bir niyet yerleştirme tekniğidir. Bu niyet, rüya sırasında \"ben rüyadayım\" farkındalığını yakalamanı sağlar. Bilinçli rüyaların ilk kapısını bu aşamada aralayacağız.';

  @override
  String get guideStage1Importance =>
      'MILD, zihnin hatırlama ve niyet oluşturma yeteneğini kullanarak, lucid dreaming\'e zihinsel bir zemin hazırlar. Hipokampus ve prefrontal korteksi aktif hale getirerek rüyada bilinçli olma ihtimalini artırır.';

  @override
  String get guideStage1Steps =>
      'Gece rüyadan uyandıktan sonra son rüyanı detaylıca hatırlamaya çalış.\nKendine şu cümleyi tekrar et: \"Bir sonraki rüyamda rüya gördüğümü fark edeceğim.\"\nBu sahneyi zihninde canlandır. Kendini rüyada farkında şekilde görselleştir.\nGözlerini kapat, bu niyetle uykuya dön.\nSabah uyandığında rüya günlüğüne detaylıca yaz.';

  @override
  String get guideStage1Criteria =>
      '1 hafta içinde en az 1 defa rüyanda rüya gördüğünü fark ettiysen bir sonraki aşamaya geçebilirsin.';

  @override
  String get guideStage1BrainNote =>
      'Bu bir uyanış yolculuğu. İlk adımda zihnini eğitmeye başlıyorsun. Her tekrar, bilinçli rüyaların bir adım daha yakın olması demektir. Unutma, sabır ve tekrar en büyük yardımcın.';

  @override
  String get guideStage2Title => '2. WBTB (Wake Back To Bed)';

  @override
  String get guideStage2Subtitle => 'Bilinçli Rüya Kapısını Aralamak';

  @override
  String get guideStage2Content =>
      'Artık zihinsel niyetini oluşturdun. Şimdi, rüyaların en yoğun yaşandığı REM evresine, bilinçli bir şekilde yeniden giriş yapmayı öğreneceğiz. WBTB tekniği, yarı uyanıklık halinde yeniden uykuya dalmanı sağlayarak lucid dream potansiyelini ciddi oranda artırır.';

  @override
  String get guideStage2Importance =>
      'WBTB ile beynin hem uyanıklık hem uyku arasında kalır. Bu geçiş noktası, lucid rüyalar için en uygun zihinsel ortamı sağlar.';

  @override
  String get guideStage2Steps =>
      'Gece uyuduktan 4–6 saat sonra alarm kurup uyan.\n15–30 dakika boyunca düşük ışıkta kitap oku, meditasyon yap ya da MILD tekrarı yap.\nBu sürenin sonunda tekrar yat ve MILD niyetiyle uykuya dal.';

  @override
  String get guideStage2Criteria =>
      '1 hafta içinde en az 2 gece rüyanda bulunduğun ortamın farkındalığını kazandıysan bir sonraki aşamaya geçebilirsin.';

  @override
  String get guideStage2BrainNote =>
      'Zihnini biraz daha açıyorsun. Rüya ile gerçeklik arasındaki perde inceliyor. Uyanıklıkla rüyayı buluşturmak üzeresin.';

  @override
  String get guideStage3Title => '3. WILD (Wake Initiated Lucid Dream)';

  @override
  String get guideStage3Subtitle => 'Bilincinle Rüyaya Doğrudan Giriş';

  @override
  String get guideStage3Content =>
      'Lucid dreaming\'in en etkileyici tekniklerinden biri olan WILD, seni doğrudan bilinçli şekilde rüya alemine taşır. Uyumadan önce zihnin uyanık kalırken bedenin uyumasına izin verirsin ve rüyaya gözlerini bile kırpmadan geçiş yaparsın.';

  @override
  String get guideStage3Importance =>
      'WILD, zihinsel berraklık ile bedensel rahatlamanın eş zamanlı yürütülmesini gerektirir. Bu teknik, doğrudan rüyaya giriş yaptığın için diğerlerinden farklıdır ve yüksek düzeyde pratik ister.';

  @override
  String get guideStage3Steps =>
      'WBTB sonrası uygula.\nYatağa uzan, tüm bedenini gevşet.\nNefesine odaklan, zihnini aktif tut.\nGözlerin kapalıyken ışıklar, desenler görebilirsin — sakince izle.\nRüyanın başladığını fark ettiğinde kontrolü ele al.';

  @override
  String get guideStage3Criteria =>
      '2 hafta içinde en az 1 kez doğrudan bilinçli bir şekilde rüya içine geçiş yaptıysan 4. aşamaya hazırsın.';

  @override
  String get guideStage3BrainNote =>
      'Şimdi ustalığın eşiğindesin. Gözlerini kapatıp başka bir dünyada açmayı öğreniyorsun. Unutma, bu teknik çok fazla pratik ister ve sabır en büyük müttefikindir.';

  @override
  String get guideStage4Title =>
      '4. Zaman Farkındalığı ve Gerçeklik Kontrolleri';

  @override
  String get guideStage4Subtitle => 'Gerçeklik Algımıza Hâkim Olmak';

  @override
  String get guideStage4Content =>
      'Artık lucid rüyaların farkındalığı başladı. Şimdi bu farkındalığı derinleştirmenin ve zaman-mekan kavramını rüyada kullanabilmenin zamanı geldi. Bu aşamada hedef: rüyadayken yıl, yaş, tarih gibi kavramları hatırlamak.';

  @override
  String get guideStage4Importance =>
      'Gerçeklik kontrolleri, rüyada olduğunun farkına varmanı kolaylaştırır. Zaman algısı ise zihinsel farkındalığın derinliğini gösterir.';

  @override
  String get guideStage4Steps =>
      'Günde en az 5–10 kez \"Şu an rüyada mıyım?\" diye sor.\nParmak saymak, yazı tekrar okumak gibi testler yap.\nUyumadan önce: \"Rüyamda hangi yılda olduğumu fark edeceğim\" niyetini tekrar et.';

  @override
  String get guideStage4Criteria =>
      '1 hafta içinde 3 gece rüyanda zamanla ilgili bir farkındalık yaşadıysan (örneğin yıl, doğum günün, takvim) → sıradaki aşamaya geçebilirsin.';

  @override
  String get guideStage4BrainNote =>
      'Artık sadece rüyada olduğunu değil, rüyadaki zamanın da farkındasın. Zihnin yeni bir boyuta geçmeye başladı.';

  @override
  String get guideStage5Title => '5. Uyku Rutini Optimizasyonu';

  @override
  String get guideStage5Subtitle => 'Lucid Rüyaya Zemin Hazırlamak';

  @override
  String get guideStage5Content =>
      'Bu aşamada doğrudan lucid rüya denemelerine ara veriyoruz. Artık beynin temel mekanizmasını desteklemek, zihinsel berraklığı derinleştirmek için düzenli bir uyku rutini inşa etme zamanı.';

  @override
  String get guideStage5Importance =>
      'Düzenli uyku ve ideal ortam lucid dreaming başarısını doğrudan etkiler. REM süresinin sağlıklı ilerlemesi için düzenli bir ritim gerekir.';

  @override
  String get guideStage5Steps =>
      'Her gün aynı saatte yat-kalk düzeni oluştur.\nYatmadan 1 saat önce dijital detoks yap.\nSessiz, karanlık, serin odada uyumaya özen göster.\nKısa meditasyonlarla zihni yatıştır.';

  @override
  String get guideStage5Criteria =>
      '10 gün boyunca 7 gece rüya günlüğü tuttuysan ve rüyaların 3\'ünde farkındalık sinyalleri yaşadıysan → sıradaki aşamaya geçebilirsin.';

  @override
  String get guideStage5BrainNote =>
      'Bir bina temelsiz olmaz. Bu aşama, bilinçli rüyalarına sağlam bir zemin kurar. Unutma, dinlenmiş bir zihin bilinçli bir zihin demektir.';

  @override
  String get guideStage6Title => '6. Dopamin Dengesi';

  @override
  String get guideStage6Subtitle => 'Zihin Kimyasını Dengelemek';

  @override
  String get guideStage6Content =>
      'Artık zihnin lucid dreaming ile tanıştı. Bu aşamada rüya pratiğinden bir adım geri çekiliyor ve zihinsel kimyanı düzenleyerek lucid rüyaların kalitesini artıracak ortamı hazırlıyoruz.';

  @override
  String get guideStage6Importance =>
      'Dopamin; motivasyon, hayal gücü ve ödül sisteminin merkezidir. Aşırı uyaranlar bu dengeyi bozar ve rüya netliğini düşürür.';

  @override
  String get guideStage6Steps =>
      '5 gün boyunca sosyal medya süreni 1 saatle sınırla.\nHafif egzersiz, yürüyüş ve güneş ışığı al.\nOmega-3 açısından zengin, şekerden uzak beslen.\nUyku öncesi odak egzersizleri yap.';

  @override
  String get guideStage6Criteria =>
      '1 hafta içinde 2 lucid rüyada bilinçli şekilde ortamı, ışığı veya bir objeyi yönettiysen son aşamaya geçebilirsin.';

  @override
  String get guideStage6BrainNote =>
      'Artık zihnini sadece eğitmedin, onun biyolojik yapısını da optimize ettin. Şimdi bilinçli rüyalar sadece mümkün değil; senin doğan haline dönüşüyor.';

  @override
  String get guideStage7Title => '7. İleri Bilinç ve Yaratıcı Manipülasyon';

  @override
  String get guideStage7Subtitle => 'Rüyanın Efendisi Olmak';

  @override
  String get guideStage7Content =>
      'Yolculuğun sonuna geldik. Bu noktada artık sadece lucid olmakla kalmayacak, rüya içeriğini bilinçli şekilde değiştirecek seviyeye ulaşacaksın. Rüya dünyanı özgürce yaratma zamanı geldi.';

  @override
  String get guideStage7Importance =>
      'Bu teknikle bilinçaltına erişebilir, korkularla yüzleşebilir, hayal ettiğin her şeyi test edebilirsin. Bu, hem zihinsel hem ruhsal bir devrimdir.';

  @override
  String get guideStage7Steps =>
      'Rüyada yapmak istediğin senaryoyu detaylıca yaz ve hayal et.\nRüyada bilinçli olarak mekanı, zamanı, karakteri veya sonucu değiştir.\nFarkındalık meditasyonlarını gündelik rutine ekle.';

  @override
  String get guideStage7Criteria =>
      '2 hafta içinde en az 2 rüyada aktif manipülasyon yaptıysan (uçmak, ortamı değiştirmek, bir şeyi çağırmak), lucid dreaming ustasısın.';

  @override
  String get guideStage7BrainNote =>
      'Bu yolculuğun sonunda sadece bilinçli rüyalar değil, hayal gücünün sınırsız potansiyeli seni bekliyor. Artık sadece uyanıkken değil, uyurken de hayatı yaratıyorsun.';

  @override
  String get guideAppBarTitle => 'Lucid Rüya Rehberi';

  @override
  String get guideIntroTitle1 => 'Lucid rüya nedir?';

  @override
  String get guideIntroContent1 =>
      'Lucid rüya (bilinçli rüya), rüyada olduğunun farkına vardığın ve rüyanı kontrol edebildiğin eşsiz bir deneyimdir.';

  @override
  String get guideIntroListTitle => 'Lucid Rüya durumunda:';

  @override
  String get guideIntroBullet1 => 'Rüya sırasında bilincin yerindedir';

  @override
  String get guideIntroBullet2 => 'Çevreni değerlendirebilirsin';

  @override
  String get guideIntroBullet3 => 'Karar verme yetin artar';

  @override
  String get guideIntroBullet4 => 'Rüyanın akışını değiştirebilirsin';

  @override
  String get guideIntroFooter =>
      'Lucid rüya, çok azımızın hayatının bir noktasında tesadüfen tecrübe edebildiği fakat doğru teknikler ile üzerinde uzmanlaşılabilen bir beceridir.';

  @override
  String get guideIntroTitle2 => 'Lucid rüya ne işe yarar?';

  @override
  String get guideBenefit1 => 'Rüyalarını yönetirsin';

  @override
  String get guideBenefit2 => 'Bilinçaltını keşfedersin';

  @override
  String get guideBenefit3 => 'Uykunun efendisi olursun';

  @override
  String get guideBenefit4 => 'Stresle daha iyi başa çıkarsın';

  @override
  String get guideIntroContent2 =>
      'Lucid rüyalar, bilinçaltının kapılarını aralayarak seni daha yüksek bir farkındalık seviyesine taşır. Bu deneyim zamanla gündelik hayatına bile yansır.';

  @override
  String get guideIntroTitle3 => 'Bu rehber nasıl kullanılır?';

  @override
  String get guideIntroContent3 =>
      'Bu rehber 7 aşamalı özel bir lucid rüya sistemi üzerine kuruludur. Her aşamada rüyalarına doğrudan etki edecek güçlü bir alışkanlık edinirsin. Hazırlamış olduğumuz kapsamlı rehber, bir kez satın alındıktan sonra seni hedeflerine ulaşana kadar her adımda yönlendirecek.';

  @override
  String get guideIntroGainTitle => 'İlerledikçe Kazanacakların';

  @override
  String get guideIntroGain1 => 'Rüyalarının derin katmanlarına erişirsin';

  @override
  String get guideIntroGain2 => 'Bilincin rüyaya yön vermeye başlar';

  @override
  String get guideIntroGain3 => 'Mekânlar ve kişiler sana göre şekil alır';

  @override
  String get guideIntroGain4 => 'Rüyalarının yönetmeni olursun';

  @override
  String get guideBuyButton => 'Rehberi Satın Al (179.00 TL)';

  @override
  String get guideNo => 'Hayır';

  @override
  String get guideYes => 'Evet';

  @override
  String get guideDebugResetTitle => 'Rehberi Sıfırla?';

  @override
  String get guideDebugResetContent =>
      'Birinci aşama hariç tüm kilitleri kapatacak. (Debug)';

  @override
  String get journalDeleteTitle => 'Rüyayı Sil?';

  @override
  String get journalDeleteContent =>
      'Bu rüyayı silmek istediğine emin misin? Bu işlem geri alınamaz.';

  @override
  String get journalDeleteConfirm => 'Sil';

  @override
  String get journalDeleteCancel => 'Vazgeç';

  @override
  String get proVersion => 'PRO';

  @override
  String get standardVersion => 'Standart';

  @override
  String get upgradeTitle => 'DreamBoat PRO\'ya Yükselt';

  @override
  String get upgradeBenefits =>
      'Reklamsız Deneyim\nTam Rüya Analizi\nLimitsiz Rüya Yorumu\nÖzel Rehber Erişimi';

  @override
  String get upgradeBtn => 'DreamBoat PRO\'yu Aç (88,99 ₺)';

  @override
  String get upgradeCancel => 'Belki daha sonra';

  @override
  String get upgradeSuccess => 'DreamBoat PRO\'ya hoşgeldin!';

  @override
  String get upgradeStart => 'Başla';

  @override
  String get proRequired => 'PRO Versiyon Gerekir';

  @override
  String get proRequiredDetail =>
      'PRO Versiyon ve En Az 5 Kaydedilmiş Rüya Gerekir';

  @override
  String get guideUnlockPro => 'PRO Sürümünün Kilidini Aç';

  @override
  String get guideUnlockHint =>
      'Rehberin kilidini açmak için PRO sürümüne geçmelisin.';

  @override
  String get guideContent => 'İçerik';

  @override
  String get guideImportance => 'Neden Önemli?';

  @override
  String get guideSteps => 'Uygulama Adımları';

  @override
  String get guideCriteria => 'Geçiş Kriteri';

  @override
  String get guideBrainNoteTitle => 'Note to Brain';

  @override
  String get guideNextStep => 'İlerle';

  @override
  String get guideDialogTitle => 'İlerlemek İstediğine Emin Misin?';

  @override
  String get guideDialogContent =>
      'Mevcut adımı gerçekleştirmeden sonraki aşamaya geçmek yolculuğuna zarar verebilir. Devam etmek istediğine emin misin?';

  @override
  String get guideDialogCancel => 'Vazgeç';

  @override
  String get guideDialogConfirm => 'Devam Et';

  @override
  String get guideStart => 'Rehbere Başla';

  @override
  String get privacyTitle => 'Gizlilik ve KVKK';

  @override
  String get privacyNoticeTitle => 'NovaBloom Studio Gizlilik Bildirimi';

  @override
  String get privacyNoticeContent =>
      'NovaBloom Studio olarak gizliliğinize en üst düzeyde önem veriyoruz. DreamBoat, rüyalarınızı güvenle kaydetmeniz ve analiz etmeniz için tasarlanmıştır.';

  @override
  String get privacySection1Title => '1. Veri Güvenliği ve İşleme:';

  @override
  String get privacySection1Content =>
      'Rüyalarınız şifrelenmiş olarak saklanır. Yapay zeka analizleri için gönderilen veriler anonimleştirilir ve asla AI modellerinin eğitimi için kullanılmaz. Verileriniz KVKK ve GDPR standartlarına uygun olarak korunur.';

  @override
  String get privacySection2Title => '2. Hesap ve Kullanım:';

  @override
  String get privacySection2Content =>
      'Uygulama tamamen anonim olarak kullanılır ve herhangi bir üyelik gerektirmez. Kişisel verileriniz ve rüya kayıtlarınız sadece cihazınızda saklanır. Herhangi bir hesap oluşturma işlemi veya kişisel veri toplama süreci bulunmamaktadır.';

  @override
  String get privacySection3Title => '3. İletişim:';

  @override
  String get privacySection3Content =>
      'Her türlü soru, öneri ve veri talepleriniz için info@novabloomstudio.com adresi üzerinden bizimle iletişime geçebilirsiniz.';

  @override
  String get privacySection4Title => '4. Sağlık ve Tıbbi Feragat (ÖNEMLİ):';

  @override
  String get privacySection4Content =>
      'Bu uygulama tıbbi bir cihaz değildir. Sunulan rüya yorumları ve analizler tamamen eğlence ve kişisel gelişim amaçlıdır, tıbbi tavsiye niteliği taşımaz. Uygulamamız herhangi bir biyometrik veya sağlık verisi toplamaz ve işlemez.';

  @override
  String get supportTitle => 'Bize Ulaşın';

  @override
  String get supportContent =>
      'Görüşleriniz NovaBloom Studio için çok değerli.\n\nÖneri, hata bildirimi veya işbirliği talepleriniz için bize e-posta gönderebilirsiniz.';

  @override
  String get supportSendEmail => 'E-posta Gönder';

  @override
  String get supportEmailNotFound => 'E-posta uygulaması bulunamadı.';

  @override
  String get debugResetTitle => 'Debug Reset';

  @override
  String get debugResetContent =>
      'Uygulama durumunu Standart versiyona döndürmek istiyor musunuz?';

  @override
  String get cancel => 'İptal';

  @override
  String get reset => 'Sıfırla';

  @override
  String get standard => 'STANDART';

  @override
  String get save => 'Kaydet';

  @override
  String get timeFormat24h => '24 Saat Formatı';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get guideSlide1Title => 'Eski Mısır’ın Bilgeliği';

  @override
  String get guideSlide1Subtitle => 'Ruhun Yolculuğuna Açılan Kapı';

  @override
  String get guideSlide1Content1 =>
      'Günümüzde adına lucid rüya dediğimiz kavramın izlerini Antik Mısır’da görmek mümkündü. Mısırlılar rüyayı, dönemin kültürel ve spiritüel inançları çerçevesinde bilinçli bir deneyim olarak yorumlarlardı.\n\nÖyle ki Firavunların, rahipler aracılığıyla rüya aleminde ilahi figürlerle etkileşim yaşadıklarına dair sembolik anlatımlar yer alır.';

  @override
  String get guideSlide1Content2 =>
      'Modern tıpta somnoloji alanındaki uyku araştırmalarında, rüya gördüğümüz evre olan REM uykusunda frontal korteksin aktif olduğu, yani beynin bilinç ve farkındalıkla ilişkili bölgelerinin uyanık haldekine benzer bir şekilde çalıştığı gözlemlenmiştir. Bu bulgular, Antik Mısır’da rüyaya atfedilen bilinçli deneyim anlatımlarıyla bazı kavramsal benzerlikler taşıdığı şeklinde yorumlanmaktadır.';

  @override
  String get guideSlide2Title => 'Tibet Rahiplerinin Meditasyonları';

  @override
  String get guideSlide2Subtitle => 'Zihnin Sınırlarını Aşmak';

  @override
  String get guideSlide2Content1 =>
      'Tibet rahipleri, bir ömür süren derin meditasyon pratikleriyle lucid rüyayı, zihinsel farkındalığı artırmaya yönelik bir içsel deneyim olarak ele aldılar.\n\nHimalayaların yüksek zirvelerinde, zihnin katmanlarını keşfeden rahipler, bilinçli rüya deneyimlerini zihinsel disiplin ve geleneksel pratiklerle destekledi.';

  @override
  String get guideSlide2Content2 =>
      'Günümüzde bazı nörolojik çalışmalarda, meditasyon pratikleri ile uyku farkındalığı arasındaki ilişki incelenmiştir.\n\nBu kadim geleneklerin ışığında hazırladığımız bu özel rehber, zihninizin derinliklerindeki bu potansiyeli uyandırmayı ve farkındalığınızı rüya alemine taşımayı hedefler. Rüyalarınızda bir izleyici olmaktan çıkıp, kendi iç dünyanızın bilinçli mimarı olma yolculuğuna şimdi başlayabilirsiniz.';

  @override
  String get guideSlide3Title => 'Rüya Kapanlarının Sırrı';

  @override
  String get guideSlide3Subtitle => 'Bilinçli Rüyaların Koruyucusu';

  @override
  String get guideSlide3Content1 =>
      'Kızılderili kültürlerinde rüya kapanı, bilinçli rüyalarla ilişkilendirilen sembolik bir obje olarak görülürdü.\n\nNesilden nesile aktarılan bu pratik, rüya deneyimlerini temsil eden kültürel bir sembol olarak yorumlanırdı. Şamanların rehberliğinde, rüya kapanı bilinçli farkındalıkla ilişkilendirilen ve ruhani bağları simgeleyen bir sembol olarak değer gördü.';

  @override
  String get guideSlide3Content2 =>
      'Modern bilgi çağında lucid rüya sadece eski kültürlerin mistik bir deneyimi değil, modern bilimsel araştırmalarda üzerinde çalışılan bir bilinç deneyimi olarak ele alınmaktadır.\n\nEn güncel araştırmalar ve nesilden nesile aktarılan öğretileri derleyerek oluşturduğumuz bu lucid rüya rehberinde, zihinsel farkındalığınızı derinleştirerek farklı deneyimleri keşfetmeniz mümkün.';

  @override
  String get guideSlide4Title => 'Lucid Rüya Rehberi';

  @override
  String get guideSlide4Content =>
      'Bu rehber nasıl kullanılır?\n\nBu rehber 7 aşamalı özel bir lucid rüya sistemi üzerine kuruludur.\nHer aşamada rüya farkındalığını destekleyen güçlü alışkanlıklar geliştirirsin.';

  @override
  String get guideSlide4GainsTitle => 'İlerledikçe Kazanacakların';

  @override
  String get guideSlide4Gain1 => 'Rüyalarının derin katmanlarına erişirsin';

  @override
  String get guideSlide4Gain2 => 'Bilincin rüyaya yön vermeye başlar';

  @override
  String get guideSlide4Gain3 => 'Mekânlar ve kişiler sana göre şekil alır';

  @override
  String get guideSlide4Gain4 =>
      'Rüyaların üzerinde daha fazla farkındalık kazanırsın.';

  @override
  String get guideSlide4ProRequired =>
      'Rehbere erişebilmek için PRO sürüme sahip olmalısın.';

  @override
  String get guideSlide4UnlockButton => 'PRO Sürümünün Kilidini Aç';

  @override
  String get guideCompleted => 'Tebrikler! Tüm rehberi tamamladın.';

  @override
  String get delete => 'Sil';

  @override
  String get actionFavorite => 'Favori';

  @override
  String get understand => 'Anladım, Devam Et';

  @override
  String get error => 'Hata';

  @override
  String get testNotification => 'Send Test Notification';

  @override
  String get testNotificationSent => 'Test notification sent!';

  @override
  String get journalSearchHint => 'Rüyalarında ara...';

  @override
  String get newDreamLoadingText => 'Rüya yorumun hazırlanıyor...';

  @override
  String get dreamInterpretationTitle => 'Rüya Yorumu';

  @override
  String get dreamInterpretationReadMore => 'Devamını Oku';

  @override
  String get dreamTooShort => 'Rüya çok kısa olduğundan yorumlanamadı.';

  @override
  String get dailyLimitReached =>
      'Günlük rüya yorumlama limitine ulaştınız (100/100).';

  @override
  String get settingsRestorePurchases => 'Satın Alımları Geri Yükle';

  @override
  String get restoreSuccess => 'PRO sürümü başarıyla geri yüklendi!';

  @override
  String get restoreNotFound => 'Önceki satın alım bulunamadı.';

  @override
  String get restoreError =>
      'Satın alımlar geri yüklenemedi. Lütfen tekrar deneyin.';

  @override
  String get restoreUnavailable =>
      'Mağaza şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get restoring => 'Geri yükleniyor...';

  @override
  String get offlineInterpretation =>
      'İnternet bağlantısı olmadığı için rüya yorumlanamadı.';

  @override
  String get offlinePurchase =>
      'Satın alma işlemi için internet bağlantısı gerekiyor.';

  @override
  String get offlineAnalysis => 'Analiz için internet bağlantısı gerekiyor.';

  @override
  String get proUpgradeSubtitle =>
      'Abonelik yok. Tek sefer satın alır, ömür boyu erişim sağlarsın.';

  @override
  String get proFeatureAdsTitle => 'Reklamsız Deneyim';

  @override
  String get proFeatureAdsSubtitle =>
      'Sadece rüyalarınıza ve rüya dünyanıza odaklanın.';

  @override
  String get proFeatureAnalysisTitle => 'Haftalık Rüya Desen Analizi';

  @override
  String get proFeatureAnalysisSubtitle =>
      'Rüyalarınız arasındaki gizli bağlantıları ortaya çıkarın. Tekrarlayan temaları, duyguları ve bilinçaltı mesajlarını zamanla keşfedin.';

  @override
  String get proFeatureGuideTitle => 'Lucid Rüya Rehberi';

  @override
  String get proFeatureGuideSubtitle =>
      'Rüyalarınızın kontrolünü elinize alın. Sıfırdan ileri seviyeye, adım adım rehberli lucid rüya teknikleri.';

  @override
  String get proProcessing => 'İşleniyor...';

  @override
  String get notifDialogTitle => 'Bildirimlere İzin Ver';

  @override
  String get notifDialogBody =>
      'DreamBoat\'un her sabah rüyalarınızı kaydetmenizi hatırlatmasına izin verin.';

  @override
  String get notifPermissionDenied => 'Bildirim İzni Reddedildi';

  @override
  String get notifOpenSettings => 'Ayarları Aç';

  @override
  String get notifOpenSettingsHint =>
      'Bildirimleri etkinleştirmek için ayarlardan izin vermeniz gerekiyor.';

  @override
  String get allow => 'İzin Ver';

  @override
  String get notifReminderBody => 'Rüyanızı kaydetmeyi unutmayın! 🌙';

  @override
  String get pressBackToExit => 'Çıkmak için tekrar geri tuşuna basın';

  @override
  String get moonSyncTitle => 'Ay ve Gezegen Senkronizasyonu';

  @override
  String get moonSyncDescription =>
      'Ay ve Gezegen Senkronizasyonu, rüyalarını gördüğün günkü Ayın evresiyle birlikte analiz ederek bilinçaltındaki duygusal dalgalanmaları Ayın evrelerine göre yorumlar. Rüyalarının kelime yoğunluğunu, duygusal tonunu ve seçtiğin ruh hâli etiketlerini Ay\'ın döngüsüyle eşleştirir. Bu sayede rüyalarının yalnızca içeriğine değil, Ay ve Gezegen düzeninin senin üzerindeki etkisini de anlarsın.';

  @override
  String get moonSyncBtn => 'Kozmik Analizi Başlat';

  @override
  String moonSyncWait(int days) {
    return 'Yeni analiz için $days gün beklemelisiniz.';
  }

  @override
  String get moonSyncMinDreams => 'En Az 5 Kaydedilmiş Rüya Gerekir';

  @override
  String get moonSyncDone => 'Aylık Kozmik Analiz Yapıldı';

  @override
  String get moonSyncProcessing =>
      'Kozmik Analiz hazırlanıyor,\nlütfen bekleyiniz.';

  @override
  String get moonPhaseNewMoon => 'Yeni Ay';

  @override
  String get moonPhaseWaxingCrescent => 'Hilal (Büyüyen)';

  @override
  String get moonPhaseFirstQuarter => 'İlk Dördün';

  @override
  String get moonPhaseWaxingGibbous => 'Şişkin Ay (Büyüyen)';

  @override
  String get moonPhaseFullMoon => 'Dolunay';

  @override
  String get moonPhaseWaningGibbous => 'Şişkin Ay (Küçülen)';

  @override
  String get moonPhaseThirdQuarter => 'Son Dördün';

  @override
  String get moonPhaseWaningCrescent => 'Hilal (Küçülen)';

  @override
  String get actionShareInterpretation => 'Yorumu\nPaylaş';

  @override
  String get sharePrivacyHint =>
      'Not: Paylaş butonu yalnızca rüya yorumunuzu paylaşır. Rüyalarınız size aittir ve herhangi bir şekilde üçüncü şahıslara gösterilmez.';

  @override
  String get moonPhaseLabel => 'Ay Evresi:';

  @override
  String get readMore => 'Devamını Oku...';

  @override
  String get tapForDetails => 'Detaylar için tıklayın...';

  @override
  String nSelected(int count) {
    return '$count Seçildi';
  }

  @override
  String get shareCardHeader => 'GÜNLÜK RÜYA YORUMUM';

  @override
  String get shareCardWatermark => 'DreamBoat App ile yorumlandı';

  @override
  String get subscriptionComingSoon =>
      'Abonelik sistemi çok yakında aktif olacak!';

  @override
  String get subscribeMonthly => 'Aylık Abone Ol';

  @override
  String get subscribeYearly => 'Yıllık Abone Ol';

  @override
  String get planMonthly => 'AYLIK';

  @override
  String get planAnnual => 'YILLIK';

  @override
  String get mostPopular => 'EN POPÜLER';

  @override
  String get subscribeNow => 'Abone Ol';

  @override
  String get billingMonthly =>
      'Aylık yinelenen ödeme. İstediğin zaman iptal et.';

  @override
  String get billingAnnual =>
      'Tek seferlik ödeme olarak faturalandırılır. Yıllık yinelenir.';

  @override
  String get proFeatureAds => 'Reklamsız Deneyim';

  @override
  String get proFeatureAnalysis => 'Haftalık Desen Analizi';

  @override
  String get proFeatureGuide => 'Lucid Rüya Rehberi';

  @override
  String get proFeatureMoonSync => 'Ay ve Gezegen Senkronizasyonu';

  @override
  String get freeTrialDays => 'Gün Ücretsiz Dene';

  @override
  String get then => 'Sonra';

  @override
  String get reviewSatisfactionTitle => 'DreamBoat\'u sevdin mi?';

  @override
  String get reviewSatisfactionContent => 'Deneyimini bizimle paylaş!';

  @override
  String get reviewOptionYes => 'Evet, bayıldım!';

  @override
  String get reviewOptionNeutral => 'Eh işte';

  @override
  String get reviewOptionNo => 'Hayır, sevmedim';

  @override
  String get reviewFeedbackTitle => 'Görüşlerin önemli';

  @override
  String get reviewFeedbackContent =>
      'Daha iyi bir deneyim için ne yapabiliriz? Bize yazmaktan çekinme.';

  @override
  String get reviewFeedbackButton => 'Bize Yaz';

  @override
  String get reviewCancel => 'Vazgeç';
}
