#encoding: utf-8
class RecordsController < ApplicationController
  layout nil
  def index
    @records = Record.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end

  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  def new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  def new_for_iframe
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  def edit
    @record = Record.find(params[:id])
    @record_answers = JSON.parse(@record.answer)

    case @record.user_type
    when "owner", "manager"
      @resolutions = {
                      "Q1_title" => "難管的員工 ──", "Q1_sub" => "公司比較優秀的員工都用自己的電腦工作，資料檔案無法掌控，真可怕", "Q1_detail" => "親愛的老闆，員工自己帶電腦原因不外乎：平板、觸控、雲端整合，這些也是Windows 8.1 的優點，如果將公司電腦升級，相信可以滿足員工需求，也能取回資料掌控權。", 
                      "Q1_1_sub" => "請問您公司自帶電腦或平板的員工，人數比例大約是：",
                      "Q2_title" => "善變的員工──", "Q2_sub" => "員工一季換一支手機，說這樣才跟得上時代，不過我總覺得東西好好的還沒壞，就不用換", "Q2_detail" => "親愛的老闆，東西有沒有壞並不是好的汰換標準，能不能趕上現代的工作效率更是重要，比方說 Windows XP 終止支援就代表那台電腦效能降低、不堪用了（了解風險請<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>看這裡</a>）。", 
                      "Q2_1_sub" => "請問您公司是否仍然在使用 Windows XP？",
                      "Q3_title" => "不拘小節的員工──", "Q3_sub" => "員工常把自己的隨身碟隨手亂放，我不想一直嘮叨這種「小事」，卻又擔心裡面其實裝的是公司檔案，一旦外流…", "Q3_detail" => "親愛的老闆，資料安全是公司大事，如果禁不了員工使用隨身碟，Windows 8.1能幫您輕鬆加密隨身碟、硬碟，從此您就可以放心了。", 
                      "Q3_1_sub" => "請您估計一下，公司檔案大約放在幾支隨身碟、外接硬碟裡？",
                      "Q4_title" => "花俏的員工──", "Q4_sub" => "現在的員工老是想要「時尚」「個人風格」的辦公設備，都不考慮對工作是否實用", "Q4_detail" => "親愛的老闆，其實時尚及個人風格，代表的是一種工作方式的進步，比如變形平板不論在桌上工作，或帶出門展示，都比傳統筆電更靈活方便（<a href='http://www.microsoft.com/en-us/showcase/details.aspx?uuid=b2de17c7-43ba-4953-9dba-122ae0e51a2f' target='_blank'>請看這支影片</a>），中看更中用。", 
                      "Q4_1_sub" => "請問員工是否有將自己的平板或智慧型手機應用於工作？",
                      "Q5_title" => "質疑我的商業直覺的員工──", "Q5_sub" => "員工很「勇於表達」，難道為了讓他們心服口服，我還要花時間找證據嗎？", "Q5_detail" => "親愛的老闆，敢於挑戰您的員工才是公司裡的寶，只靠過來人的經驗，說服力的確不足，應試著導入更科學的管理工具，理性的幫助員工與您一起進步，如 Office 2013 的 Power View。", 
                      "Q6_title" => "上班也在 FB 的員工──", "Q6_sub" => "公私分明是我的工作觀念，何況員工上社交網站難免影響工作", "Q6_detail" => "親愛的老闆，新科技讓工作與生活的界線變得模糊，也顛覆了過去的工作觀念，因此 Windows 8.1 讓員工不必上社群網站也能隨時關注客戶訊息，找回公私新平衡。",
                      "Q6_1_sub" => "請問您是否覺得客戶使用 FB、Line 等社交平台的比例日漸升高？" 
                    }
      
      @understandings = {
                         "Q1" => "難管的員工，只是想做得更好，才會帶自己的電腦來工作，如果您改用 Windows 8.1，便能了解新的工作方式有多迷人　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 >></a>", 
                         "Q2" => "善變的員工中，有相當多人是以研究新舊產品間的創新為己任，如果公司想做科技投資，這些人是很好的顧問，也可以請他們來研究繼續使用 Windows XP 的風險　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows XP 風險 >></a>", 
                         "Q3" => "不拘小節的員工，有些天份與不拘小節是綁在一起的，例如創造力！公司對於資料的保密，要利用嚴謹的規則來取代限制，如強制將每一支使用的隨身碟都加密　<a href='http://windows.microsoft.com/zh-tw/windows-8/using-device-encryption' target='_blank'>了解更多 Windows 8.1 的加密功能 >></a>", 
                         "Q4" => "面對花俏的員工，您可以仔細觀察他們是如何花悄的工作，其中的行動工作能力或許是公司下一步競爭力的良方呢　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>", 
                         "Q5" => "質疑老闆判斷的員工，俗話說在組織內唱反調的員工才難得，當您把更直接的證據拿出來時，也才能讓組織真正學到您的經驗與知識　<a href='http://office.microsoft.com/zh-tw/excel-help/HA102901475.aspx' target='_blank'>了解更多 Office 2013 的 PowerView >></a>", 
                         "Q6" => "關於上班也在 FB 的員工，說真的是有不少在浪費上班時間，但如果能讓員工透過 FB 更了解客戶，相信對業務也是有很大幫助的　<a href='http://windows.microsoft.com/zh-tw/windows-8/personalize-pc-tutorial#customize' target='_blank'>了解更多 Windows 8.1 動態磚>></a>"
                        }
      
    when "worker"
      @resolutions = {
                      "Q1_title" => "老闆堅持電腦壞了才能換──", "Q1_sub" => "大家的電腦都好慢，且職人雜誌的 e 化工作效率提升術，都跟我無關，因為公司電腦太過老舊", "Q1_detail" => "路不轉人轉，您可以帶自己的電腦工作，不論平板或電腦，只要是跑 Windows 8.1，就能與流行的雲端、觸控接軌，還可藉此刺激老闆幫公司電腦升級。", 
                      "Q1_1_sub" => "請問您的公司是否還在使用 Windows XP？",
                      "Q1_2_sub" => "請問您是否自帶電腦／平板上班？",
                      "Q2_title" => "老闆的生活比工作先進──", "Q2_sub" => "老闆擁有高級的平板或智慧手機，但只是拿來娛樂用", "Q2_detail" => "確實，很多老闆並不善於在工作上使用新工具，您可以推薦老闆使用 Windows平板，當他發現平板也能跑 Office 處理商務時，或許也會為員工更新設備，縮短公司數位落差。", 
                      "Q3_title" => "老闆就是疑神疑鬼──", "Q3_sub" => "看到我們上社群網站就覺得我們在摸魚，可是我們需要關注客戶動態啊！", "Q3_detail" => "Windows 8.1 動態磚讓您隨時看見客戶最新社群訊息，不必特別進入社群網站，治好老闆疑心病。", 
                      "Q3_1_sub" => "請問您會在社群網站與客戶互動嗎？",
                      "Q3_2_sub" => "請問您上班時需要上社群網站來幫助工作嗎？",
                      "Q4_title" => "老闆對開會有執念──", "Q4_sub" => "不管大小事，老闆都要「開個會」，每次趕回公司開會的交通時間和費用，其實都是一種浪費", "Q4_detail" => "Windows 8.1 平板與 Office 2013 完美整合雲端，便於您利用交通時間處理公務，或建議老闆導入 Office 365 高畫質視訊會議，電腦 + 網路連線就能隨時開會，免交通費、免設備維護。", 
                      "Q4_1_sub" => "請問您每週開會時間累計大約：",
                      "Q5_title" => "老闆不信任新科技──", "Q5_sub" => "老闆總認為新東西不可靠，而忽略舊東西容易出事的風險", "Q5_detail" => "Windows XP 和 Office 2003 是十幾年前的產品，不符合現代的安全標準，2014/4/8 終止支援後將不再提供新的安全更新，立即升級 Windows 8.1 和 Office 2013 才是真正可靠。", 
                      "Q5_1_sub" => "請問貴公司這兩年內是否有爆發電腦中毒事件：",
                      "Q6_title" => "老闆喜歡喊口號創新──", "Q6_sub" => "老闆總認為新東西不可靠，而忽略舊東西容易出事的風險", "Q6_detail" => "您可以先投資自己，在自己的電腦上使用 Windows 8.1，再建議老闆升級公司電腦，踏出實質創新的第一步。" 
                    }

      @understandings = {
                         "Q1" => "老闆堅持電腦壞了才能換，對很多白手起家的老闆是合理的想法，要改變他們需依循「身教重於言教」的原則，您不妨嘗試自帶先進的電腦工作，改善自己的產能，順便教導老闆新科技的價值　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 >></a>", 
                         "Q2" => "老闆的生活比工作先進，其實這樣的老闆遠較「生活比工作落後」的老闆好多了，只要讓他們了解 Windows 平板對工作的幫助，或許明天就配一台給您了　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>", 
                         "Q3" => "老闆疑神疑鬼時，就要直接請他們來看臉書上客戶的動態，但如果您太常上 FB 從事自己的社交活動，請自重　<a href='http://windows.microsoft.com/zh-tw/windows-8/personalize-pc-tutorial#customize' target='_blank'>了解更多 Windows 8.1 動態磚>></a>", 
                         "Q4" => "老闆確實是需要開會的，只能請他們儘量利用科技來開會，並且提升自己的行動工作能力　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>、<a href='http://www.microsoft.com/taiwan/office365/smb/default.aspx' target='_blank'>了解更多 Office 365 >></a>", 
                         "Q5" => "要幫助不信任新科技的老闆，要善用「事件」，比如新聞報導或調查報告，讓老闆了解老舊設備的風險　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows XP 風險 >></a>", 
                         "Q6" => "老闆喜歡喊口號創新？難免啦，畢竟真的創新難為，但工作不只是為了公司，也是為了自己，投資自己創新所需的一切，才是真正的職場晉升之道　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 的創新之處>></a>"
                        }
    end

    unless(session[:record_id] && ( params[:id] == session[:record_id].to_s ) && @record)
      redirect_to root_path, alert: "記錄不存在"
    end
  end

  def edit_for_iframe
    @record = Record.find(params[:id])
    @record_answers = JSON.parse(@record.answer)
    
    case @record.user_type
    when "owner", "manager"
      @resolutions = {
                      "Q1_title" => "難管的員工 ──", "Q1_sub" => "公司比較優秀的員工都用自己的電腦工作，資料檔案無法掌控，真可怕", "Q1_detail" => "親愛的老闆，員工自己帶電腦原因不外乎：平板、觸控、雲端整合，這些也是Windows 8.1 的優點，如果將公司電腦升級，相信可以滿足員工需求，也能取回資料掌控權。", 
                      "Q1_1_sub" => "請問您公司自帶電腦或平板的員工，人數比例大約是：",
                      "Q2_title" => "善變的員工──", "Q2_sub" => "員工一季換一支手機，說這樣才跟得上時代，不過我總覺得東西好好的還沒壞，就不用換", "Q2_detail" => "親愛的老闆，東西有沒有壞並不是好的汰換標準，能不能趕上現代的工作效率更是重要，比方說 Windows XP 終止支援就代表那台電腦效能降低、不堪用了（了解風險請<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>看這裡</a>）。", 
                      "Q2_1_sub" => "請問您公司是否仍然在使用 Windows XP？",
                      "Q3_title" => "不拘小節的員工──", "Q3_sub" => "員工常把自己的隨身碟隨手亂放，我不想一直嘮叨這種「小事」，卻又擔心裡面其實裝的是公司檔案，一旦外流…", "Q3_detail" => "親愛的老闆，資料安全是公司大事，如果禁不了員工使用隨身碟，Windows 8.1能幫您輕鬆加密隨身碟、硬碟，從此您就可以放心了。", 
                      "Q3_1_sub" => "請您估計一下，公司檔案大約放在幾支隨身碟、外接硬碟裡？",
                      "Q4_title" => "花俏的員工──", "Q4_sub" => "現在的員工老是想要「時尚」「個人風格」的辦公設備，都不考慮對工作是否實用", "Q4_detail" => "親愛的老闆，其實時尚及個人風格，代表的是一種工作方式的進步，比如變形平板不論在桌上工作，或帶出門展示，都比傳統筆電更靈活方便（<a href='http://www.microsoft.com/en-us/showcase/details.aspx?uuid=b2de17c7-43ba-4953-9dba-122ae0e51a2f' target='_blank'>請看這支影片</a>），中看更中用。", 
                      "Q4_1_sub" => "請問員工是否有將自己的平板或智慧型手機應用於工作？",
                      "Q5_title" => "質疑我的商業直覺的員工──", "Q5_sub" => "員工很「勇於表達」，難道為了讓他們心服口服，我還要花時間找證據嗎？", "Q5_detail" => "親愛的老闆，敢於挑戰您的員工才是公司裡的寶，只靠過來人的經驗，說服力的確不足，應試著導入更科學的管理工具，理性的幫助員工與您一起進步，如 Office 2013 的 Power View。", 
                      "Q6_title" => "上班也在 FB 的員工──", "Q6_sub" => "公私分明是我的工作觀念，何況員工上社交網站難免影響工作", "Q6_detail" => "親愛的老闆，新科技讓工作與生活的界線變得模糊，也顛覆了過去的工作觀念，因此 Windows 8.1 讓員工不必上社群網站也能隨時關注客戶訊息，找回公私新平衡。",
                      "Q6_1_sub" => "請問您是否覺得客戶使用 FB、Line 等社交平台的比例日漸升高？" 
                    }
      
      @understandings = {
                         "Q1" => "難管的員工，只是想做得更好，才會帶自己的電腦來工作，如果您改用 Windows 8.1，便能了解新的工作方式有多迷人　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 >></a>", 
                         "Q2" => "善變的員工中，有相當多人是以研究新舊產品間的創新為己任，如果公司想做科技投資，這些人是很好的顧問，也可以請他們來研究繼續使用 Windows XP 的風險　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows XP 風險 >></a>", 
                         "Q3" => "不拘小節的員工，有些天份與不拘小節是綁在一起的，例如創造力！公司對於資料的保密，要利用嚴謹的規則來取代限制，如強制將每一支使用的隨身碟都加密　<a href='http://windows.microsoft.com/zh-tw/windows-8/using-device-encryption' target='_blank'>了解更多 Windows 8.1 的加密功能 >></a>", 
                         "Q4" => "面對花俏的員工，您可以仔細觀察他們是如何花悄的工作，其中的行動工作能力或許是公司下一步競爭力的良方呢　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>", 
                         "Q5" => "質疑老闆判斷的員工，俗話說在組織內唱反調的員工才難得，當您把更直接的證據拿出來時，也才能讓組織真正學到您的經驗與知識　<a href='http://office.microsoft.com/zh-tw/excel-help/HA102901475.aspx' target='_blank'>了解更多 Office 2013 的 PowerView >></a>", 
                         "Q6" => "關於上班也在 FB 的員工，說真的是有不少在浪費上班時間，但如果能讓員工透過 FB 更了解客戶，相信對業務也是有很大幫助的　<a href='http://windows.microsoft.com/zh-tw/windows-8/personalize-pc-tutorial#customize' target='_blank'>了解更多 Windows 8.1 動態磚>></a>"
                        }
      
    when "worker"
      @resolutions = {
                      "Q1_title" => "老闆堅持電腦壞了才能換──", "Q1_sub" => "大家的電腦都好慢，且職人雜誌的 e 化工作效率提升術，都跟我無關，因為公司電腦太過老舊", "Q1_detail" => "路不轉人轉，您可以帶自己的電腦工作，不論平板或電腦，只要是跑 Windows 8.1，就能與流行的雲端、觸控接軌，還可藉此刺激老闆幫公司電腦升級。", 
                      "Q1_1_sub" => "請問您的公司是否還在使用 Windows XP？",
                      "Q1_2_sub" => "請問您是否自帶電腦／平板上班？",
                      "Q2_title" => "老闆的生活比工作先進──", "Q2_sub" => "老闆擁有高級的平板或智慧手機，但只是拿來娛樂用", "Q2_detail" => "確實，很多老闆並不善於在工作上使用新工具，您可以推薦老闆使用 Windows平板，當他發現平板也能跑 Office 處理商務時，或許也會為員工更新設備，縮短公司數位落差。", 
                      "Q3_title" => "老闆就是疑神疑鬼──", "Q3_sub" => "看到我們上社群網站就覺得我們在摸魚，可是我們需要關注客戶動態啊！", "Q3_detail" => "Windows 8.1 動態磚讓您隨時看見客戶最新社群訊息，不必特別進入社群網站，治好老闆疑心病。", 
                      "Q3_1_sub" => "請問您會在社群網站與客戶互動嗎？",
                      "Q3_2_sub" => "請問您上班時需要上社群網站來幫助工作嗎？",
                      "Q4_title" => "老闆對開會有執念──", "Q4_sub" => "不管大小事，老闆都要「開個會」，每次趕回公司開會的交通時間和費用，其實都是一種浪費", "Q4_detail" => "Windows 8.1 平板與 Office 2013 完美整合雲端，便於您利用交通時間處理公務，或建議老闆導入 Office 365 高畫質視訊會議，電腦 + 網路連線就能隨時開會，免交通費、免設備維護。", 
                      "Q4_1_sub" => "請問您每週開會時間累計大約：",
                      "Q5_title" => "老闆不信任新科技──", "Q5_sub" => "老闆總認為新東西不可靠，而忽略舊東西容易出事的風險", "Q5_detail" => "Windows XP 和 Office 2003 是十幾年前的產品，不符合現代的安全標準，2014/4/8 終止支援後將不再提供新的安全更新，立即升級 Windows 8.1 和 Office 2013 才是真正可靠。", 
                      "Q5_1_sub" => "請問貴公司這兩年內是否有爆發電腦中毒事件：",
                      "Q6_title" => "老闆喜歡喊口號創新──", "Q6_sub" => "老闆總認為新東西不可靠，而忽略舊東西容易出事的風險", "Q6_detail" => "您可以先投資自己，在自己的電腦上使用 Windows 8.1，再建議老闆升級公司電腦，踏出實質創新的第一步。" 
                    }

      @understandings = {
                         "Q1" => "老闆堅持電腦壞了才能換，對很多白手起家的老闆是合理的想法，要改變他們需依循「身教重於言教」的原則，您不妨嘗試自帶先進的電腦工作，改善自己的產能，順便教導老闆新科技的價值　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 >></a>", 
                         "Q2" => "老闆的生活比工作先進，其實這樣的老闆遠較「生活比工作落後」的老闆好多了，只要讓他們了解 Windows 平板對工作的幫助，或許明天就配一台給您了　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>", 
                         "Q3" => "老闆疑神疑鬼時，就要直接請他們來看臉書上客戶的動態，但如果您太常上 FB 從事自己的社交活動，請自重　<a href='http://windows.microsoft.com/zh-tw/windows-8/personalize-pc-tutorial#customize' target='_blank'>了解更多 Windows 8.1 動態磚>></a>", 
                         "Q4" => "老闆確實是需要開會的，只能請他們儘量利用科技來開會，並且提升自己的行動工作能力　<a href='http://windows.microsoft.com/zh-tw/windows-8/tablets?woldogcb=0' target='_blank'>了解更多 Windows 平板 >></a>、<a href='http://www.microsoft.com/taiwan/office365/smb/default.aspx' target='_blank'>了解更多 Office 365 >></a>", 
                         "Q5" => "要幫助不信任新科技的老闆，要善用「事件」，比如新聞報導或調查報告，讓老闆了解老舊設備的風險　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows XP 風險 >></a>", 
                         "Q6" => "老闆喜歡喊口號創新？難免啦，畢竟真的創新難為，但工作不只是為了公司，也是為了自己，投資自己創新所需的一切，才是真正的職場晉升之道　<a href='http://www.microsoft.com/zh-tw/windows/business/retiring-xp.aspx' target='_blank'>了解更多 Windows 8.1 的創新之處>></a>"
                        }
    end
  end

  def create
    @record = Record.new(params[:record])

    respond_to do |format|
      if @record.save
        session[:record_id] = @record.id

        if params[:from] == "iframe"
          format.html { redirect_to edit_for_iframe_record_path(@record) }
          format.json { render json: @record, status: :created, location: @record }
        else
          format.html { redirect_to edit_record_path(@record) }
          format.json { render json: @record, status: :created, location: @record }
        end
      else
        flash[:alert] = "#{ @record.errors.full_messages.join("\\n").html_safe }"
        format.html { redirect_to :back }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @record = Record.find_by_id(params[:id])
    @signup = Signup.find_by_record_id(params[:id]) || Signup.create(:record_id => @record.id)

    params[:signup][:having_mobile_device] = params[:signup][:having_mobile_device].to_json
    params[:signup][:company_mobile_device] = params[:signup][:company_mobile_device].to_json
    params[:signup][:pc_os] = params[:signup][:pc_os].to_json
    params[:signup][:office_version] = params[:signup][:office_version].to_json

    respond_to do |format|
      if ( @record.user_fbid || @record.update_attributes(params[:record]) )
        @signup.update_attributes(params[:signup])

        if params[:from] == "iframe"
          format.html { redirect_to redirect_to new_for_iframe_records_path, notice: '參加成功。' }
          format.json { head :no_content }
        else
          format.html { redirect_to root_path, notice: '參加成功。'  }
          format.json { head :no_content }
        end

      else
        flash[:alert] = "#{ @record.errors.full_messages.join("\\n").html_safe }"
        format.html { redirect_to :back }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
end
