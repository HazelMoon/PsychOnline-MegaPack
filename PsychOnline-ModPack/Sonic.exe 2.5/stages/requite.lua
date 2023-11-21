function onUpdatePost()
    setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup') - 1)
    setObjectOrder('boyfriendGroup',getObjectOrder('gfGroup') - 1)
end