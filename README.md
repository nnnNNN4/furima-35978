# テーブル設計

## users テーブル

| Column                     | Type   | Options                     |
| ------------------------   | ------ | --------------------------- |
| nickname                   | string | null:false                  |
| encrypted_password         | string | null:false                  |
| email                      | string | null:false, unique: true    |
| last_name                  | string | null:false                  |
| first_name                 | string | null:false                  |
| last_name_kana             | string | null:false                  |
| first_name_kana            | string | null:false                  |
| birthday                   | date   | null:false                  |

### Association
  ・has_many :items 
  ・has_many :cards 
  ・has_many :orders

## items テーブル

| Column                    | Type       | Options             |
| ------------------------- | ---------- | ------------------- |
| name                      | string     | null:false          |
| description               | text       | null:false          |
| category_name_id          | integer    | null:false          |
| status_id                 | integer    | null:false          |
| shipping_charge_id        | integer    | null:false          |
| shipping_area_id          | integer    | null:false          |
| days_to_ship_id           | integer    | null:false          |
| price                     | integer    | null:false          |
| user                      | references | foreign_key:true    |

### Association
  ・belongs_to :user
  ・has_one :order

## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | foreign_key :true              |
| user   | references | foreign_key :true              |

### Association
  ・belongs_to :item
  ・belongs_to :user
  ・has_one :address

## addresses テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| postal_code      | string     | null:false        |
| shipping_area_id | integer    | null:false        |
| municipality     | string     | null:false        |
| address          | string     | null:false        |
| building_name    | string     |                   |
| phone_number     | string     | null:false        |
| order            | references | foreign_key: true |

### Association
  ・belongs_to :order

## cards テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| card_token       | string     | null:false        |
| customer_token   | integer    | null:false        |
| user             | references | foreign_key:true  |

### Association
  ・belongs_to :user