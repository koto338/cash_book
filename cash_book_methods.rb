def get_carry_over
#  ユーザーが入力した前月残高を受け取る
  puts '前月残高を入力してください。'
  carry_over = gets.chomp

  while carry_over.match?(/[0-9]/) == false
    puts '前月残高を正しい形式で入力してください。'
    carry_over = gets.chomp
  end
  carry_over
end

def get_date
#   ユーザーが入力した日付を受け取る
  puts '日付を入力してください。'
  date = gets.chomp

  while date.match?(/[0-9]/) == false
    puts '日付を正しい形式で入力してください。'
    date = gets.chomp
  end
  date
end

def get_other
#   ユーザーが入力した相手先（支払先）を受け取る
  puts '相手先（支払先）を入力してください。'
  other = gets.chomp

  while other.size > 50
    puts '相手先を50:文字以内で入力してください。'
    other = gets.chomp
  end
  other
end

def get_overview
#   ユーザーが入力した概要を受け取る
  puts '概要を入力してください。'
  overview = gets.chomp

  while overview.size > 100
    puts '概要を100文字以内で入力してください。'
    overview = gets.chomp
  end
  overview
end

def get_code
#   ユーザーが入力した科目コードを受け取る
  puts '科目コードを選択してください'
  print "1:旅費交通費\s 2:車両費\s 3:報酬前渡\s 4:通信費\s 5:租税公課\s 6:接待交際費\s  7:備品・消耗品費\s 8:会議費\s 9:雑費\s 10:租税公課"
  puts
  code = gets.to_s.chomp

  while code.match?(/[1-8]/) == false
    puts '科目コードを正しい形式で入力してください。'
    code = gets.to_s.chomp
  end
  
  case code
  when '1'
    6111
  when '2'
    6222
  when '3'
    6333
  when '4'
    6555
  when '5'
    6666
  when '6'
    6777
  when '7'
    5555
  when '8'
    4444
  when '9'
    3333
  when '10'
    2222  
  end
end

def gets_receipt_payment
  # ユーザーが入力した収入または支払を受け取る
  puts '収入または支払を選択してください。'
  print "1:収入\s 2:支払"
  puts 
  receipt_payment = gets.chomp

  while receipt_payment.match?(/[1-2]/) == false
    puts '正しい形式で入力してください。'
    receipt_payment = gets.chomp
  end
  receipt_payment
end



def get_amount
    # ユーザーが入力した金額を受け取る
  puts '金額を入力してください'
  amount = gets.chomp

  while amount.match?(/[0-9]*/) == false
    puts '金額を正しい形式で入力してください。'
  end
  amount
end






