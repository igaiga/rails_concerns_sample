# app/models/concerns/taggable.rb
# concernsの名前は *able と付けると読み易い
# Bookクラスでinclude Taggableされた場合の実行結果を #=> で書いてある
module Taggable
  extend ActiveSupport::Concern
  # ↑これを書くと以下の便利な機能が使える

  included do
    # includeされたときに呼ばれる
    # トップレベルに書きたいことはここに書く
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings 
  end

  # インスタンスメソッドになる
  def tag_names
    tags.map(&:name)
  end

  def foo
    "foo"
  end
  # Book.new.foo #=> "foo"

  module ClassMethods
    # module ClassMethodsを中で定義すると、その中のメソッドをクラスメソッドにできる
    def bar
      "bar"
    end
    # Book.bar #=> "bar"
  end

  private

  # privateメソッドを書くとそのままprivateでincludeされる
  def private_bar
    "private_bar"
  end
  # Book.new.private_bar #=> NoMethodError

end
