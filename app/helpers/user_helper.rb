module UserHelper
    def months_collection
      ["01","02","03","04","05","06","07","08","09","10","11","12"]
    end

    def years_collection
      current_year = Date.today.year
      years_collection_list = []
      for y in 0..10 do
          years_collection_list << {yy: (current_year + y).to_s.slice(2,3), yyyy: (current_year + y).to_s}
      end
      years_collection_list
    end

    def card_brands
      { "logo/visa.svg":            {"height": "20", "width": "49"},
        "logo/master-card.svg":     {"height": "20", "width": "34"},
        "logo/saison-card.svg":     {"height": "20", "width": "30"},
        "logo/jcb.svg":             {"height": "20", "width": "32"}, 
        "logo/american_express.svg":{"height": "20", "width": "21"},
        "logo/dinersclub.svg":      {"height": "20", "width": "32"},
        "logo/discover.svg":        {"height": "20", "width": "32"},
      }
    end

    def sidemenu(active_menu)
      menulist = {
        "メニュー": [
          {title:"マイページ",path: "user_path(current_user.id)", method: "get", value: ""},
          # {title:"お知らせ",path: "user_path(current_user.id)", method: "get", value: "1"},
          {title:"いいね！一覧",path: "favorites_user_path(current_user.id)", method: "get", value: "", class: "mypage__nav__list-item"},
          {title:"出品する",path: "new_item_path", method: "get", value: ""},
          #{title:"下書き一覧", path: "user_path(current_user.id)", method: "get", value: ""},
          {title:"出品した商品 - 出品中", path: "user_on_sale_items_path(current_user.id)", method: "get", value: ""},
          #{title:"出品した商品 - 取引中", path: "user_path(current_user.id)", method: "get", value: ""},
          {title:"出品した商品 - 売却済み", path: "user_sold_items_path(current_user.id)", method: "get", value: ""},
          #{title:"購入した商品 - 取引中", path: "user_purchased_items_path(current_user.id)", method: "get", value: ""},
          {title:"購入した商品 - 過去の取引", path: "user_purchased_items_path(current_user.id)", method: "get", value: ""},
          # {title:"ニュース一覧", path: "user_path(current_user.id)", method: "get", value: ""},
          # {title:"評価一覧", path: "user_path(current_user.id)", method: "get", value: ""},
          # {title:"ガイド", path: "user_path(current_user.id)", method: "get", value: ""},
          # {title:"お問い合わせ", path: "user_path(current_user.id)", method: "get", value: ""},
        ],
        "設定": [
          {title:"プロフィール", path: "new_user_self_introduction_path(current_user.id)", method: "get", value: ""},
          {title:"発送元・お届け先住所変更", path: "edit_user_sending_destination_path(current_user.id, current_user.sending_destination.id)", method: "get", value: ""},
          {title:"支払い方法", path: "user_cards_path(current_user.id)", method: "get", value: ""},
          {title:"メール/パスワード", path: "edit_user_registration_path", method: "get", value: ""},
          {title:"本人情報", path: "edit_user_profile_path(current_user.id, current_user.profile.id)", method: "get", value: ""},
          #{title:"電話番号の確認", path: "user_path(current_user.id)", method: "get", value: ""},
        ] 
      }

      menulist.each{|head, items|
        items.each do |item|
          if item[:title]==active_menu
            item[:class]="mypage__nav__list-item__active"
          else
            item[:class]="mypage__nav__list-item"
          end
        end
      }

      menulist
    end

    def user_items_tab(active_tab)
      tablist=[
        {tab:"onsale",  head:"出品中", path: "user_on_sale_items_path(current_user.id)", class: "itemlist-tab"},
        {tab:"sold",    head:"売却済み", path: "user_sold_items_path(current_user.id)", class: "itemlist-tab"},
        {tab:"purchased",  head:"購入した商品", path: "user_purchased_items_path(current_user.id)", class: "itemlist-tab"},
      ]
      tablist.each do |tab|
        tab[:class]="itemlist-tab__active" if tab[:tab]==active_tab
      end
      puts tablist
      tablist
    end
end  