scaffoldで作成したコントローラーの記述が明らかに少ないのは、
Baseを継承しているから？

そこの機能にプリミティブな機能は、記述されているのか？
そのファイルはどこにある？

https://ja.stackoverflow.com/questions/53669/rails%E3%81%AEactioncontrollerbase%E3%81%AEbase%E3%82%AF%E3%83%A9%E3%82%B9%E3%81%AF%E3%81%A9%E3%81%93%E3%81%AB%E5%AD%98%E5%9C%A8%E3%81%99%E3%82%8B

hoge::Baseとhogeの二段階になっているのはなぜ？
インターフェース？

::ってなに？


C3

何らかの変更を行う際には、常に「自動化テスト」を作成して、機能が正しく実装されたことを確認する

test driven development(TDD): red ・ green ・REFACTOR

C4
railsを上手く使うためのruby
<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
Railsの組み込み関数、カッコを使わないメソッド呼び出し、シンボル、そしてハッシュ

オブジェクトが何をするのかを説明するのは簡単です。オブジェクトとは、いつどんな時にもメッセージに応答するものです

unless, if 後置
メソッドの引数を省略することも可能です（カッコですら省略可能です）
 string_message  
デフォルト引数設定済み、
暗黙の戻り値がある = 最後に計算された値


module ApplicationHelper

includeメソッドを使ってモジュールを読み込むことができます。これをミックスイン（mixed in）とも呼びます
railsではinclude不要


array 
「破壊的」メソッド   = !

a = [42, 8, 17]            # いったん元の値に戻す
>> a.push(6)                  # 6を配列に追加する
=> [42, 8, 17, 6]
>> a << 7                     # 7を配列に追加する
=> [42, 8, 17, 6, 7]

配列と範囲はいずれも、ブロックを伴うさまざまなメソッドに対して応答

symbol (任意の文字列の唯一の大本みたいなもの）
https://qiita.com/yyykms123/items/6a6ae7fe8cd9263a3d1c

ハッシュではシンボルをキーとして使うことが一般的
h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
h2 = { name: "Michael Hartl", email: "michael@example.com" }


inspect method これは要求されたオブジェクトを表現する文字列を返します。
>> p :name             # 'puts :name.inspect' と同じ
:name

class,object, method
クラスメソッドはString.newのように.で表記され、インスタンスメソッドはString#lengthのように#


ObjectClass
BasicObjectClass

これはInterface的な話？、なぜ二つ似たものがある？
柔軟性？


課題
Stringを生成した何らかのクラスもあるはずです。

railsは、Rubyの組み込みクラスにも変更を加えている
(ex. blank? method)


class defenition
ユーザー名とメールアドレス（属性: attribute）に対応するアクセサー（accessor） をそれぞれ作成します。アクセサーを作成すると、そのデータを取り出すメソッド（getter）と、データに代入するメソッド（setter）をそれぞれ定義してくれます。

インスタンス作成時に属性を設定する場合、ハッシュをnewの引数にとる
（マスアサインメント）

C5 edit layout file with bootstrap
モックアップ（Webの文脈ではよくワイヤーフレームと呼ばれます）
を先につくる
（なつかしい、AdobeUXみたいなやつで昔つくった）

assets pipeline
image_tag
がapp/assets/image/を探す


パーシャル（partial）　
コンポーネント的な話、header部品は別ファイルで切り出そう
_header.html.erbの先頭にあるアンダースコアに注目してください。このアンダースコアは、パーシャルで使う普遍的な命名規約

asset pipeline
アセットディレクトリ、マニフェストファイル、プリプロセッサエンジン

hoge/assets 配下に対して特別な処理が走る (railsでは３つある）
それぞれassets配下には、applicationという名前のマニフェストファイルがあり、結合されている
railsにはプリプロセッサエンジンが搭載されていて、拡張子を見て、結合を行う。

メリット
開発時には関心の分離ができる。公開時には、統合されたファイルが利用されるので高速応答可能

scss　ネスト構文、変数
hoge{--}
hoge fuga{--}

=>
hoge {
 –
 fuga{– }
}

$variable



integration test
ページ遷移とかをテストできる



C6 ユーザーのモデル
ActiveRecordがDBとやりとりする

change, method up,down, create,drop 
「Active Record マイグレーション」を参照してください。
ここらへんの説明よくわからんかった

HogeBaseに実装があり、Hogeはabstract classだった

Model.find(id)
Model.find_by(attribute: “hoge”)
Model.all


rails test:models

Validation　テストをかき、実行しながら、確りはじけているか確認していく
あ

validationのtestを書く(RED)　→ validationを書く(GREEN)


文字列の配列を簡単に作れる%w[]　　　　　便利？
format: { with: /<regular expression>/ }
ああああ
uniqueness,  don't distinguish Upperletter and Lower Letter


データベースのインデックス
データベースにカラムを作成するとき、そのカラムでレコードを検索する（find）必要が生じるかどうかを考えることは重要です
indexなし: find→ full-table scan O(N)
indexあり: 索引検索 (分割してるの？）

マイグレーションファイル
class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
  end
end
add_index: Model, Column, (Option?)

Indexと大文字小文字の混同の相性が悪いらしい
→ callbackで小文字にして保存する

多重代入（Multiple Assignment）
!!でそのオブジェクトが対応する論理値オブジェクトに変換できる
!!authenticate(“password”)
-> true or false


本番環境でUserモデルを使うためにはRender上でもマイグレーションを実行する必要があります。まずは設定ファイルを作りましょう。
$ touch bin/render-build.sh


ワード
yml, callback .sh

C7 コントローラのアクションの実装
開発環境用
<%= debug(params) if Rails.env.development? %>

Railsにはテスト環境（test）、開発環境（development）、そして本番環境（production）

Railsアプリケーションで好まれているRESTアーキテクチャ（コラム 2.2）の慣習に従うことにしましょう。つまり、データの作成、表示、更新、削除をリソース（Resources）として扱うということです。HTTP標準には、これらに対応する4つの基本操作（POST、GET、PATCH、DELETE）が定義されているので、これらの基本操作を各アクションに割り当てていきます


データベースへの操作を、
ユーザーがアクセスできるWebリソース上に実装しよう、ということでしょ

resources :users
=>ユーザーのURLを生成するための多数の名前付きルーティング（5.3.3）と共に、RESTfulなUsersリソースで必要となるすべてのアクションが利用できるようになるのです

params[:id]は暗黙的に、コントローラに渡されてるのか
リクエストに付随するのか

debuggerメソッド
確認できる
サーバーを立ち上げたターミナルで

バグ解決で使う


form_with
<%= form_with(model: @user) do |f| %>
      <%= f.label :name %>
      <%= f.text_field :name %>

      <%= f.label :email %>
      <%= f.email_field :email %>

      <%= f.label :password %>
      <%= f.password_field :password %>

      <%= f.label :password_confirmation, "Confirmation" %>
      <%= f.password_field :password_confirmation %>

      <%= f.submit "Create my account", class: "btn btn-primary" %>
    <% end %>
<label for="user_name">Name</label>
<input type="text" name="user[name]" id="user_name" />



mix-in(sass)

cssの固まり
変数的に扱うことに価値があるのだろう（見やすい、応用しやすい）


Strong Parameters
マスアサインメントで, new(params[user:])とコンストラクターを呼ぶのはキケンらしい（マスアサインメント脆弱性）

curlなどで権限を改ざんしてハッキングできるらしい。
JSの不正実行みたいなもんか

StrongParameter　→　必須パラメータと許可済みパラメータの指定ができる

Rails全般の慣習として、複数のビューで使われるパーシャルは専用のディレクトリ「shared


課題　わからない
未送信のユーザー登録フォーム（図 7.14）のURLと、送信済みのユーザー登録フォーム（図 7.20）のURLを比べてみると、URLが違っています。その理由を考えてみてください。

TLS 
ネットワークに情報を流す際に暗号化する
Transport Layer Security


現在のRenderではすべての接続でTLSを利用していますが、Webホスト側がこのように振る舞うことに依存しない方がセキュリティ上有利です。
⇒
production.rbのコードをたった1行変更するだけで、あらゆるブラウザでTLSを強制し、httpsによる安全な通信を確立できます。具体的には次のリスト 7.34に示すように、config.force_sslをtrue




エラー発生
ビルドした際に、/signupにアクセスできない

pg is not part of the bundle
gem

productionのみでインストールするようになっている。
だから仕様通りで、これはRender上ではインストールされているはず

https://zenn.dev/seetsuko/articles/a3d9d2c4d8fffe


PostgreSQLの仕様
The region where your PostgreSQL instance runs. Services must be in the same region to communicate privately and you currently have services running in Singapore.
C8 基本的なログイン機構
HTTP Request : StateLess
HTTPのリクエスト1つ1つは、それより前のリクエストの情報をまったく利用できない、独立したトランザクションとして扱われます
⇒
ブラウザのあるページから別のページに移動したときに、ユーザーのIDを保持しておく手段がHTTPプロトコルの「中には」まったくありません
⇒
セッション（Session）を使う ≒ cookiesを使う (in rails)


SESSION自体もRESTfulに実装するらしい
（現状CRUDにて操作される、という認識しかない）

rails generate controllerをすると、controllerにアクションが実装されるだけでなく、それがデフォルトで返すビューファイルが実装されてしまう。

SessionsにはModelがない（つくってない
⇒ActiveRecordの機能を使えない

Modelがないので pathとスコープを明示して、POSTリクエストを送る
form_with(url: login_path, scope: :session)



POSTリクエストされると、その先のリソースでは、paramsが使える（復習）
params[:session]にデータが格納されているのは、form_withのscopeがsessionだからかな


ただしセッションは引き続きセッションハイジャック攻撃に対して脆弱です。セッションハイジャックとは、攻撃者があるユーザーのセッションidのコピーを手に入れて、そのユーザーとしてログインするという攻撃方法です（この手順はセッションリプレイ攻撃と呼ばれます
reset_session      # ログインの直前に必ずこれを書くこと
      log_in user


findは存在しないと、例外を発生する
find_by はnilを返すだけである

||=

ぼっち演算子&.　使う意味ある？

testを分割して行う方法がある
setup関数にsuperと書いて、どうのこうの
（今は飛ばす）

C9 発展的な認証機能
remember me ＝ユーザーのログイン状態をブラウザを閉じた後でも有効にする
=> 永続クッキー

sessionはブラウザを閉じると消える

仮想のattribute remember_tokenって
ただメンバ変数的なあつかい？？

ブラウザに持たせておく、という機能が当然必要だよね

tokenを発行する意味は、有効期限の管理？
（時間で切れる、ログアウトで消す）


class内メソッド定義で
class
	def hoge  #method
	end

	User.fuga  #static method
	end
end
みたいな感じだと思う



２つのエラーのところ、
①　1つのブラウザでログアウトした後に、もう一つのUIに表示されているログアウトを押し、deleteリクエストを送ると、destroyが呼ばれ、log_outが呼ばれ、userのメソッドのforgetが呼ばれる。
これは、現在ログインしているcurrent_userに対して作用するが、current_userはnilになっているので、nilにはforgetがないとしてバグる
＝＞ loginしているときしか、logoutを呼べなくする
（destroyはリクエストに応答して必ず呼ばれる）



assert_equalの引数は「期待する値、実際の値」

セッションリプレイ攻撃


本番環境　マイグレーションミスってる 
Usersがないらしい
relation "users" does not exist at character 491

C10 UserのRestful Resourceの完成
Webブラウザは、表 7.1でRESTの慣習として要求されているPATCHリクエストをそのままでは送信できないので、RailsはPOSTリクエストと隠しinputフィールドを利用して、PATCHリクエストを「偽造」しています2 。
<input name="_method" type="hidden" value="patch" />

二つのform（ users/newとusers/id/editからのform)
のリクエストの判別はrailsがやっているんだよね、たぶん

user Resourceで、いろいろつくってるから、リクエストに対するルーティングを


受け入れテスト（Acceptance Tests）
認証（authentication）はサイトのユーザーを識別することであり、
認可（authorization）はそのユーザーが実行可能な操作を管理することです。

:see_otherの意味がいまいちわからない
turbo?

ミドルウェア
before_actionがどっちかしか呼べないバグが発生している！
上から処理する形で、意図していないテストケースで、呼ばれてしまっているだけ
（log_inしているはずなのに、log_in?がfalseを返している
sessionのところ、中途半端に書き換えていたせいで、バグっていた
フレンドリーフォワーディング
ユーザーを適切なページに転送するには、リクエストされたページをどこかに保存しておく必要があります

サンプルデータ、

ページネーション（pagination）
=ページ分割

ある程度の腕前を持つ攻撃者なら、コマンドラインでDELETEリクエストを直接発行するという方法でサイトの全ユーザーを削除できるでしょう
＝＞どうやって？？？

アカウントの有効化
（1）有効化トークンやダイジェストを関連付けておいた状態で、（2）有効化トークンを含めたリンクをユーザーにメールで送信し、（3）ユーザーがそのリンクをクリックすると有効化できるようにする、

コールバック
before_save, before_create, ブロックorメソッドを与える
何らかのメソッドを実行する前に、ある処理をさせる
分かりづらいけどユーザーのidが組み込まれたurlと一緒
edit_account_activation_url(@user.activation_token, ...)
＝　https://www.example.com/account_activations/q5lt38hQDc_959PVoo6b7A/edit

なんでeditか？
＝＞ 「activationを”作る?”」からcreateの方がいいんだけど、メールでのアクティベーションのUIが、リンクのブラウザ上でのクリックしかなくて、GETリクエストしか投げられないから、（受けられないから）、それに対応して行う必要がある。

Restfulリソースとしてactivationを実装したときに、そのリクエストに対応するアクションはeditとrailsではなっている

メールプレビュー機能がある

メタプログラミングはRubyのきわめて強力な機能であり、「黒魔術」とも呼ばれるRailsの一見魔法のような機能の多くは、Rubyのメタプログラミングによって実現されています

authenticated?を抽象化する
＝＞メタプログラミングして、<hoge>_digestを呼び出す
"#{attribute}_digest"

アカウントの有効化とremember_me機能が、ともに
「tokenを発行＆DB保存して、別のアクセス時に同じか検証する」
という共通する構造を持っているから

テストの分割のくだり
別にクラスを切り出して、setupのオーバーライド
それを継承するんじゃなくて、

それぞれのテストケースのクラスごとにsetupかけばよくないか？
あ、ほんのちょっとの共通処理をまとめたいの？

もともとやりたかったことは、「長いテストの分割」

C12 パスワード再設定

getリクエストが飛び、editに　⇒　メアドparamからUserを検索し、ValidならPostなりPatchなりのリクエストを飛ばす＝＞しかし,param消えちゃうらしい
（送れないの？？）
＝＞「隠しフィールド」


C13 tweet
user_id:reference
=>自動的にインデックスと外部キー参照2 付きのuser_idカラムが追加され、UserとMicropostを関連付けする下準備

add_index のときに、[:user_id, :created_at]　配列で指定
＝＞　複合キーが生成される
（「Idごとに、生成順で」という検索を高速化したいという実装）

belongs_to


Webアプリケーション用のデータモデルを構築するときは、モデルとモデルの間に関連付け（association）を設定できるようにしておくことが重要です

1対多のとき、belongs_to/has_manyの関係

Micropost.create
Micropost.create!
Micropost.new
＝＞
ユーザーとの関連付けを経由してマイクロポストを作成
user.microposts.create
user.microposts.create!
user.microposts.build

default scope
default_scope -> { order(created_at: :desc) }
ラムダ関数　ブロック（4.3.2）を引数に取り、Procオブジェクトを返します

依存関係
dependent: :destroy
親が消えたら、子も死ぬ

Model.count vs Model.length
=> count is faster


response.body = そのページの完全なHTML


ツイートができないバグがある
=>ただcorrect_userというbefore_actionをcreateに誤ってかけていた
createは、log_inしていれば、だれからでもできる paramsにvalidなcontentさえあれば

ページネーションのリンクがない

will_paginateが表示できてない

投稿数依存らしい、たぶん溢れないとページネーションリンクが出てこない

＝＞　ただそれだけだった…

ただインテグレーションテストが通らない、fixture間違ってるかな


michael（テストユーザー）の投稿数は３４で十分
shared/feedもレンダリングされているので、will_paginateは含まれている
これが動くことは確認済み

すなわち、@feed_itemsが送れてない？？
いや確り取得できている

いったん解決はあきらめる
(自分が作ったユーザーでは同様の操作でpaginationの表示された/homeをレンダーしている）

該当するnextボタンはこれ
<a rel="next" href="/microposts?page=2">2</a>

検知するテストコード
assert_select 'a[href=?]', '/?page=2'



画像のアップロード機能

imageはattachして、マイクロポストに紐づけているが、
他のテキストとかも、attachできるのかな


３重のバリデーション作ったはずなのに、でっかい画像アップできる
ああ、５MBいってないのか、でかいけど


、ImageMagick
というサービスでリサイズする


C14 follow機能

has_many through



users has many followの構造
この問題　＝　follow_modelをつくって、そこにfollowされた人の名前やメアドまで入れる
「誰がuser_id」どんな誰をfollowしているか

（followed_idでUsersを検索すればいいだけのことは誰でも分かる）


この問題の根本は、必要な抽象化を行なっていないことです。正しいモデルを見つけ出す方法の1つは、Webアプリケーションにおけるfollowingの動作をどのように実装するかをじっくり考えることです。
＝＞どのように実装するか…
＝＞REST
RESTアーキテクチャは、作成されたり削除されたりするリソースに関連していたことを思い出してください。

followするとき、何がcreateされるのか？

非対称なrelationshipが作ったり、消されたりする


user.active_relationships.build(followed_id: ...)
「active_relationshipというのを使うから、それを探しに行ってもRelationshipしかないから動かない」
みたいな説明がなされているけど、じゃあRelationshipっていうの使えばいいじんじゃないか？
どっから出てきたんだ、activeは


ユーザーに直接紐づけたいのは、「followした」=active_followなのか


外部キーや、その他情報を、belongs_toやhas_manyなどで書いてあげると、active_relationが使えるようになるらしい

別のデータベースにアクセスするためのカラム
外部キー（foreign key）


多対多の関係づけ
has_many_through

一つデータベースを通して、二重構造にする
しかし、アクセス的には、Userの直下にあるように(microposts)のように扱えるようになる


 resources :users do
    member do
      get :following, :followers
    end
  end


Hotwire?

バグ
activateされていないユーザー、
登録した後にすぐにプロフィールページに飛ばされた＝ログイン済み状態


説明できるべきこと
・MVCモデル
・Restfulなリソースづくり、その利点
・RailsがやっていることとプレーンなRubyのやることの理解
・Session、永続ログインの仕組み
・ブラウザのやっていること
・サイトへの攻撃の方法と対策
・メール認証のやり方
・各種ツールのまとめ(正規表現、メール
・各種コマンドのリファレンス作成
・各種便利な関数のリファレンス作成

それぞれのWebアプリの基本的な機能に対して具体的な実装形式と概念的な手順の説明



気づいたこと
・loginしているのに、signupできちゃう
