
class CreateSenators < ActiveRecord::Migration 
  def change
    create_table :senators do |t|
      t.string :firstname
      t.string :lastname
      t.string :party
      t.string :state
      t.string :district
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :twitter_id
      t.date :birthdate
    end

    create_table :representatives do |t|
      t.string :firstname
      t.string :lastname
      t.string :party
      t.string :state
      t.string :district
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :twitter_id
      t.date :birthdate
    end
  end

end
