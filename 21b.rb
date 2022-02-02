WEAPONS = [[8, 4, 0], [10, 5, 0], [25, 6, 0], [40, 7, 0], [74, 8, 0]]
ARMORS  = [[0, 0, 0], [13, 0, 1], [31, 0, 2], [53, 0, 3], [75, 0, 4], [102, 0, 5]]
RINGS   = [[0, 0, 0], [0, 0, 0], [25, 1, 0], [50, 2, 0], [100, 3, 0], [20, 0, 1], [40, 0, 2], [80, 0, 3]]

MY_HP     = 100

BOSS_HP   = 104
BOSS_DAMAGE = 8
BOSS_ARMOR  = 1

def battle_sim(damage, armor)
  hp = MY_HP
  boss_hp = BOSS_HP

  loop do
    boss_hp -= [damage - BOSS_ARMOR, 1].max
    break if boss_hp <= 0

    hp -= [BOSS_DAMAGE - armor, 1].max
    break if hp <= 0
  end

  hp > 0
end

worst_cost = 0

WEAPONS.each do |weapon|
  ARMORS.each do |armor|
    RINGS.permutation(2).each do |rings|
      d = weapon[1] + rings.map { _1[1] }.sum
      a = armor[2] + rings.map { _1[2] }.sum
      unless battle_sim(d, a)
        cost = weapon[0] + armor[0] + rings.map { _1[0] }.sum
        worst_cost = cost if cost > worst_cost
      end
    end
  end
end

puts worst_cost
