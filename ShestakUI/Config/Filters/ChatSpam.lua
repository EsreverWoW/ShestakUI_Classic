local T, C, L, _ = unpack(select(2, ...))
if T.classic or C.chat.enable ~= true or C.chat.spam ~= true then return end

T.ChatSpamList = {
	"золото",
	"з0л0т0",
	"з0л0то",
	"золота",
	"голд",
	"г0лд",
	"золотишко",
	"золатишко",
	"блестяшки",
	"блестяшkи",
	"блестяхи",
	"монетки",
	"м0нетки",
	"монеты",
	"порталы",
	"портал",
	"порты",
	"порт",
	"mastercard",
	"webmoney",
	"вебмани",
	"яндекс",
	"skype",
	"skуpe",
	"skуpе",
	"скайп",
	"скаип",
	"sкайп",
	"аттестат",
	"анус",
	"анальное",
	"visа",
	"qiwi",
	"qiwі",
	"к/г",
	"ісq",
	"іcq",
	"аsя",
	"asя",
	"dving.ru",
	"nigmаz.сom",
	"rpgdealer.ru"
}
