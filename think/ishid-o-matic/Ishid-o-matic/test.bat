copy :Ishid-o-matic/startup-sequence_A to Ishid-o-matic:s/startup-sequence
if exists Ishid-o-matic:devs/keymaps d
        echo >>Ishid-o-matic:s/startup-sequence "setmap d*N"
endif
type >>Ishid-o-matic:s/startup-sequence :Ishid-o-matic/startup-sequence_B
