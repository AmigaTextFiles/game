--- The cheap game show - "CAR"
    しょぼゲー「カーレースみたいな避けゲー」
- Release by fumi2kick - Oct.28.2005

Binary releasea for PSP

* 無駄話

今をさかのぼること 20数年前。
パーソナルコンピュータは「マイコン」と呼ばれていて、BASIC が
全盛であり、個人用コンピュータが出たばっかりのころ。
ゲームは基本的に自分で作るのが基本であった。
そんなころ、割とメジャーだったのが「スクロールしてくる障害物
を避ける」内容のゲーム。私も散々作った物だった。
今にして思えば全然つまらないものではあるんだけれども、当時は
割と必死に遊んだ物だった。まあ、自分で作った物だからかもしれ
ないけれども。

あの頃が懐かしくなったので作ってみました。

手軽に作れるしょぼゲー万歳。

* ルール

赤い車をガンガン避けろ！

* 遊び方

縦スクロールゲームです。
できるだけ PSP を縦に持ってお遊びください。

タイトル画面で任意のボタンを押すとスタートします。
このとき、△、□、×を押すとそれぞれ敵車のパターンが固定になり
ます。(ランダムシードが固定値になる)
スコアアタックにご利用ください。(例：△スタートで 438000点)
それ以外のボタン(○、Ｌ、Ｒ)でスタートすると大体毎回ランダムに
なります。

* build
  for PSP
    % make

  for PC/MAC (require psptoolchain)
    % make pc

  require Libs.
    SDL
    SDL_image
    SDL_mixer
    zlib
    libpng

* source code

  system
    bootmain.*
    debug.*
    input.*
    sound.*
    grp_screen.*
    grp_texture.*
    grp_sprite.*
    psp_debug.c
    psp_grp_screen.c

  game
    gamemain.*

ビルドしてできあがった tgcs_car/ ディレクトリに data/ ディレ
クトリにあるデータを全てコピーしてください。

* 制作環境

 BGM
   ACID と ACID LOOPS で適当に
 SE
   FRUITY LOOPS 5 で適当に
 Graphic
   Fireworks で適当に
 Programing
   Meadow と cygwin で適当に

* credit

  released by fumi2kick
  programing and other : rerofumi <rero2@yuumu.org>
  distribution : http://www.fumi2kick.com/
