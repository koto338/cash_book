require_relative 'cash_book_methods.rb'
require 'csv'

# cash.csvのファイルパスを作成
filepath = "#{__dir__}/cash.csv"

# ファイルを追記書き込みモードで開く
File.open(filepath, "a+") do |file| 

  if File.empty?("cash.csv")
  # ファイルの中身がなければ

  # ヘッダー、前月繰り越し金額、出金の明細を格納
    header = "日付, 相手先（支払先）, 摘要, 科目コード, 収入金額, 支払金額, 残高, 6111 旅費交通費,\
    6222 車両費, 6333 報酬前渡, 6555 通信費, 6666 租税公課, 6777 接待交際費, 5555 備品・消耗品費,\
    4444 会議費, 3333 雑費, 2222 租税公課"

    # ユーザーが入力した前月残高を受け取る
    carry_over = get_carry_over
    
    # 前月繰り越しを書き込む
    last_month = " "", 前月残高【繰越】,"","","","", #{carry_over}"
  
    #bomを作成 UTF-8で開く
    bom ="\xEF\xBB\xBF"
     
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
    # 収入金額なら
    incom = amount
  else
    # 支払金額なら
    pay = amount
  end
  
  
  # 残高を計算
  balance =

  if carry_over
    # 前月繰越があれば
    if incom
      # 収入金額
      carry_over.to_i + amount.to_i
    else
      # 支出金額
      carry_over.to_i - amount.to_i
    end
  else
    # 前月金額がなければ、最終行の残高を取得
    last_csv = CSV.read("cash.csv") 
    *a, b = last_csv 
    last_money = b[6]
    # last_money = array.delete("\"")
    if incom
      # 収入金額
      last_money.to_i + amount.to_i
    else
      # 支出金額
      last_money.to_i - amount.to_i
    end
  end
  

  # 出金の明細を格納
  if pay
    if code == 6111
      journal_6111 = pay
    elsif code == 6222
      journal_6222 = pay
    elsif code == 6
      journal_6444 = pay
    elsif code == 6555
      journal_6555 = pay
    elsif code == 6666
      journal_6666 = pay
    elsif code == 6777
      journal_6777 = pay
    elsif code == 5555
      journal_5555 = pay
    elsif code == 4444
      journal_4444 = pay
    elsif code == 3333
      journal_3333 = pay
    elsif code == 2222
      journal_2222 = pay
  end  
end


  # それぞれカンマ区切りでcashに代入
  cash = "#{date}, #{other}, #{overview}, #{code}, #{incom}, #{pay} ,#{balance},\
  #{journal_6111}, #{journal_6222}, #{journal_6444}, #{journal_6555}, #{journal_6666},\
  #{journal_6777}, #{journal_5555}, #{journal_4444}, #{journal_3333}, #{journal_2222}"
  file.puts cash
end


# cash.csvを読み込みモードで開く
File.open(filepath, "r") do |file| 
  # 各行について処理
  file.each do |line|
    puts line
  end
end
