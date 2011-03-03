* Quit Mail.app
* Open terminal
* run `sqlite3 ~/Library/Mail/'Envelope Index' 'update messages set flags = flags | 196608 where flags & 196608 != 196608;'`
* Open Mail.app