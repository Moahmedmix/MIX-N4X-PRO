# MIX‑N4X Dev Test Harness (Roblox Studio) — حزمة اختبار آمنة

ملاحظة مهمة
- هذه الحزمة مخصّصة للاختبار داخل Roblox Studio فقط. الكود يفحص RunService:IsStudio() ويمنع التشغيل خارج بيئة التطوير.
- لا تُستخدم هذه الأدوات في سيرفرات عامة أو مع أدوات استغلال (مثل Delta). أي استخدام خارج بيئة التطوير يقع تحت مسؤوليتك.

الغرض
- تزويد واجهة تطوير (UI) وتست‑هارنس بسيط لمحاكاة ميزات مثل AutoFarm، Visuals، وToggles بشكل آمن داخل بيئة التطوير.
- يتم توجيه جميع الأوامر عبر RemoteEvent مقيّد بصاحب المشروع (OwnerUserId). أمثلة السلوك هنا تطبع أو تزيد قيمة اختبارية فقط — لا تغيّ�� منطق السيرفر الحقيقي إلا بعد دمج آمن.

الملفات المهمة
- src/Shared/ConfigModule.lua — الإعدادات الأساسية (عدّل OwnerUserId).
- src/Server/TestHarness.server.lua — سيرفر‑سعيد، يحاكي leaderstats وعمليات AutoFarm في Studio.
- src/Client/DevUI.local.lua — LocalScript لواجهة التحكم (توضع في StarterPlayerScripts).
- src/Shared/MockGameAPI.lua — واجهة/نموذج لربط المنطق الحقيقي للعبة.
- dev/DevConfig.json — نموذج إعدادات قابل للتعديل.
- LICENSE (MIT)، CHANGELOG.md، .gitignore

التركيب السريع (Roblox Studio)
1. افتح مشروعك في Roblox Studio.
2. ضع `ConfigModule.lua` و `MockGameAPI.lua` داخل مجلد ModuleScripts (مثلاً: ReplicatedStorage.Modules أو ServerScriptService.Modules).
3. اضف `TestHarness.server.lua` داخل `ServerScriptService`.
4. اضف `DevUI.local.lua` داخل `StarterPlayer > StarterPlayerScripts`.
5. افتح `ConfigModule.lua` وعدّل `OwnerUserId = <YOUR_USERID>` إلى رقم حسابك.
6. شغّل Play (Start) أو Play Here داخل Studio وانتبه لكونك صاحب المشروع لتفعيل الواجهة.
7. الواجهة سترسل أوامر للسيرفر عبر RemoteEvent `DevHarnessEvent`. السيرفر يحاكي تغيّر الـ leaderstats (XP/Cash) ويطبع لوجات.

كيف تدمج مع لعبتك الحقيقية
- اقرأ `MockGameAPI.lua` كمثال. استبدل الدوال التجريبية بدوال سيرفرية حقيقية موثوقة (Server‑side) تتعامل مع قواعد اللعب.
- لا تنفّذ تغييرات تمنح مزايا للاعبين في سيرفرات عامة دون مراقبة/سجلات.

إذا تريد أعمل لك:
- نسخة مُعدّة مسبقًا تضع الملفات في مواقع محددة داخل مشروعك (انسخ ولصق).
- إضافة وظائف تسجيل (logging) مفصّل مع RemoteEvents للسماح بتحليل الاختبارات.
- مولّد ملفات Config قابل للكتابة داخل Studio (ModuleScript StringValue) — بدل كتابة ملف خارجي.

ردّ عليّ برقم UserId (اختياري) لأضعه مكان الـ PLACEHOLDER أو قلّي لو تريد أبدأ بترتيب الملفات داخل مشروعك مباشرة.
