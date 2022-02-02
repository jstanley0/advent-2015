MY_HP      = 50
MY_MANA   = 500

BOSS_HP    = 55
BOSS_DAMAGE = 8

def battle_sim(spent_mana, mana, hp, boss_hp, turn = 0, shield_timer = 0, poison_timer = 0, recharge_timer = 0)
  # hard mode!
  if turn == 0
    hp -= 1
    return if hp <= 0
  end

  # apply effects
  if shield_timer > 0
    armor = 7
    shield_timer -= 1
  else
    armor = 0
  end

  if poison_timer > 0
    boss_hp -= 3
    poison_timer -= 1
  end

  if recharge_timer > 0
    mana += 101
    recharge_timer -= 1
  end

  if boss_hp <= 0
    if spent_mana < $best_cost
      $best_cost = spent_mana
      puts "new best cost: #$best_cost"
    end
    return
  end

  if turn == 0
    # cast spell
    return if mana < 53 || spent_mana > $best_cost

    battle_sim(spent_mana + 53, mana - 53, hp, boss_hp - 4, turn ^ 1, shield_timer, poison_timer, recharge_timer) if mana >= 53
    battle_sim(spent_mana + 73, mana - 73, hp + 2, boss_hp - 2, turn ^ 1, shield_timer, poison_timer, recharge_timer) if mana >= 73
    battle_sim(spent_mana + 113, mana - 113, hp, boss_hp, turn ^ 1, 6, poison_timer, recharge_timer) if mana >= 113 && shield_timer == 0
    battle_sim(spent_mana + 173, mana - 173, hp, boss_hp, turn ^ 1, shield_timer, 6, recharge_timer) if mana >= 173 && poison_timer == 0
    battle_sim(spent_mana + 229, mana - 229, hp, boss_hp, turn ^ 1, shield_timer, poison_timer, 5) if mana >= 229 && recharge_timer == 0
  else
    # boss attack
    hp -= [BOSS_DAMAGE - armor, 1].max
    return if hp <= 0 # player died

    battle_sim(spent_mana, mana, hp, boss_hp, turn ^ 1, shield_timer, poison_timer, recharge_timer)
  end
end

$best_cost = 1e9

battle_sim(0, MY_MANA, MY_HP, BOSS_HP)
puts $best_cost
