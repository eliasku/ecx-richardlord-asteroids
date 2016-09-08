import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

class EcxAsteroidsMake extends hxmake.Module {

	function new() {
		config.classPath = ["src"];
		config.testPath = [];
		config.dependencies = [
			"ecx" => "haxelib",
			"ecx-common" => "haxelib",
			"openfl" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);
	}
}