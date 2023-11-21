--UPDATE CHECK

curentVersion = 0;
targetVersion = 0;
targetVersionString = "0.5.1";
function onCreate()

bit = string.gsub(version,"%.","")
bit2 = string.gsub(targetVersionString,"%.","")
curentVersion = tonumber(bit)
targetVersion = tonumber(bit2)
end
function onStartCountdown()

	if curentVersion < targetVersion then
		--do when outdated
		debugPrint("YOU PSYCH ENGINE BUILD ("..version..") IS OUTDATED!!!")
		debugPrint("UPDATE TO THE LATEST PSYCH ENGINE BUILD ("..targetVersionString..")")
		return Function_Stop;
	end

end