class Player
  
  def play_turn(warrior)
    @max_health = 20
    if @health == nil then @health = @max_health end
    

    being_attacked(warrior)
    warrior_actions(warrior)
    warrior_health(warrior)
    
    
  end
  
  
  def check_back(warrior)
    if warrior.feel(:backward).empty? == true then
      warrior.walk!(:backward)
    elsif warrior.feel(:backward).captive? == true then
      warrior.rescue!(:backward)
    elsif warrior.feel(:backward).enemy? == true then
      warrior.attack!(:backward)
    end
  end
  
   
  def being_attacked(warrior)
    @underattack = @health > warrior.health
  end
  
  
  def warrior_actions(warrior)
    if warrior.look(:forward).any? { |space| space.captive? } and warrior.feel(:forward).captive?
      warrior.rescue!
      @captive_found = 1
    elsif warrior.look(:forward).any? { |space| space.captive? } and @captive_found != 1
      warrior.walk!
    elsif warrior.look(:forward).any? { |space| space.enemy? } and @captive_found == 1
      warrior.shoot!
    elsif warrior.feel.wall? == true then
      warrior.pivot!
      @captive_found = 1 
    elsif @underattack == true and warrior.health < 5 then
      warrior.walk!(:backward)
    elsif @underattack == true and warrior.feel.empty? then
      warrior.walk!
    elsif @underattack == true and warrior.feel.enemy? then
      warrior.attack!
    elsif @underattack == true and warrior.feel.captive? then
      warrior.rescue!
    elsif @underattack == false and warrior.feel.empty? and warrior.health == @max_health then
      warrior.walk!
    elsif @underattack == false and warrior.feel.enemy? and warrior.health == @max_health then
      warrior.attack!
    elsif @underattack == false and warrior.feel.captive? and warrior.health == @max_health then
      warrior.rescue!
    elsif @underattack == false and warrior.health < @max_health and warrior.look(:forward).any? { |space| space.enemy? } == false
      warrior.rest!
    elsif @underattack == false and warrior.health < @max_health and warrior.look(:forward).any? { |space| space.enemy? } == true
      warrior.shoot!
    end
  
  end
  
  def warrior_health(warrior)
    @health = warrior.health
  end
end 
