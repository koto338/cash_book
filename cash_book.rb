require_relative 'cash_book_methods.rb'
require 'csv'

# cash.csvのファイルパスを作成
filepath = "#{__dir__}/cash.csv"

# ファイルを追記書き込みモードで開く
File.open(filepath, "a+") do |file| 

  if File.empty?("cash.csv")
  # ファイルの中身がなければ
  # ヘッダー、前月繰り越し金額を書き込む

    header = "日付, 相手先（支払先）, 摘要, 科目コード, 収入金額, 支払金額, 残高"

    # ユーザーが入力した前月残高を受け取る
    carry_over = get_carry_over

    last_month = " "", 前月残高【繰越】,"","","","", \"#{carry_over}\""

    bom ="\xEF\xBB\xBF"
     #bomを作成 UTF-8で開く
    
    file << bom
    file.puts header
    file.puts last_month
  end


  # ユーザーが入力した日付を受け取る
  date = get_date

  # ユーザーが入力した相手先（支払先）を受け取る
  other = get_other

  # ユーザーが入力した概要を受け取る
  overview = get_overview

  # ユーザーが入力した科目コードを受け取る
  code = get_code

  # ユーザーが入力した収入または支払を受け取る
  receipt_payment = gets_receipt_payment

  # ユーザーが入力した金額を受け取る
  amount = get_amount


  if receipt_payment == "1"
    # 収入金額ならincomに格納
    incom = amount
  else
    # 支払金額ならpayに格納
    pay = amount
  end

  # 残高を計算
  balance =
  if carry_over
    # 前月金額があれば
    if incom
      # 収入金額
      carry_over.to_i + amount.to_i
    else
      # 支出金額
      carry_over.to_i - amount.to_i
    end
  else
    last_csv = CSV.read("cash.csv", liberal_parsing: true) 
    *a, b = last_csv 
    array = b.last
    last_money = array.delete("\"")
    if incom
      # 収入金額
      last_money.to_i + amount.to_i
    else
      # 支出金額
      last_money.to_i - amount.to_i
    end
  end

  # それぞれカンマ区切りでcashに代入
  cash = "#{date}, #{other}, #{overview}, #{code},#{incom},#{pay}, #{balance}"
  file.puts cash
end

# cash.csvを読み込みモードで開く
File.open(filepath, "r") do |file| 
  # 各行について処理
  file.each do |line|
    puts line
  end
end