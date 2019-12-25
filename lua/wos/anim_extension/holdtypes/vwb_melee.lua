local DATA = {}
DATA.Name = 'vwb melee'
DATA.HoldType = 'vwb_melee'
DATA.BaseHoldType = 'melee2'
DATA.Translations = {} 
DATA.Translations[ACT_MP_SWIM] = {{Sequence = 'swim_idle_knife',Weight = 1}}
DATA.Translations[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = {{Sequence = 'judge_b_left_t2',Weight = 1},{Sequence = 'judge_b_left_t3',Weight = 1},{Sequence = 'judge_b_left_t1',Weight = 1}}
DATA.Translations[ACT_MP_JUMP] = {{Sequence = 'phalanx_a_run',Weight = 1}}
DATA.Translations[ACT_MP_STAND_IDLE] = {{Sequence = 'h_idle',Weight = 1}}
DATA.Translations[ACT_MP_RUN] = {{Sequence = 'judge_r_run',Weight = 1}}
DATA.Translations[ACT_MP_WALK] = {{Sequence = 'judge_r_run',Weight = 1}}
wOS.AnimExtension:RegisterHoldtype(DATA)
