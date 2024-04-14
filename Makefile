.PHONY: fvm_install
fvm_install:
	fvm install

.PHONY: clean
clean:
	fvm flutter clean
	fvm flutter pub get

.PHONY: test
test:
	fvm flutter test

.PHONY: coverage
coverage:
	fvm flutter test --coverage
	genhtml coverage/lcov.info -o coverage/result
	open coverage/result/index.html

.PHONY: runner
runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: watch
watch:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: get_and_watch
get_and_watch:
	fvm flutter pub get
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: native_splash_create
native_splash_create:
	fvm flutter pub run flutter_native_splash:create

.PHONY: launcher_icons
launcher_icons:
	fvm flutter pub run flutter_launcher_icons

# Xcodeを開く
.PHONY: open_xcode
open_xcode:
	open ios/Runner.xcworkspace

# Podfileの更新（Podfile.lockを削除してpod install --repo-update）
.PHONY: pod_update
pod_update:
	cd ios && rm Podfile.lock && pod install --repo-update

# リリース用のIPAをビルド ( open build/ios/ipa )
.PHONY: build_ipa
build_ipa:
	fvm flutter build ipa --export-options-plist="ios/ExportOptions.plist"

# アクティブなシミュレータの一覧を取得
.PHONY: get_active_simulator
get_active_simulator:
	xcrun simctl list | grep Booted

# 指定したシミュレーターのステータスバーを設定
.PHONY: set_simulator_status_bar
set_simulator_time:
	xcrun simctl status_bar "iPhone 11 Pro Max" override --time "11:40"
	xcrun simctl status_bar "iPhone 11 Pro Max" override override --operatorName '' --cellularMode active
	xcrun simctl status_bar "iPhone 8 Plus" override --time "11:40"
	xcrun simctl status_bar "iPhone 8 Plus" override override --operatorName '' --cellularMode active

# 指定したシミュレーターのステータスバーをクリア
.PHONY: clear_simulator_status_bar
clear_simulator_time:
	xcrun simctl status_bar "iPhone 11 Pro Max" clear
	xcrun simctl status_bar "iPhone 8 Plus" clear
