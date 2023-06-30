--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.2.8) ~  Much Love, Ferib 

]]--

do
	local v0 = string.char;
	local v1 = string.byte;
	local v2 = string.sub;
	local v3 = bit32 or bit;
	local v4 = v3.bxor;
	local v5 = table.concat;
	local v6 = table.insert;
	local function v7(v24, v25)
		local v26 = 0;
		local v27;
		while true do
			if (v26 == 1) then
				return v5(v27);
			end
			if (v26 == 0) then
				v27 = {};
				for v43 = 1, #v24 do
					v6(v27, v0(v4(v1(v2(v24, v43, v43 + 1)), v1(v2(v25, 1 + (v43 % #v25), 1 + (v43 % #v25) + 1))) % 256));
				end
				v26 = 1;
			end
		end
	end
	local v8 = tonumber;
	local v9 = string.byte;
	local v10 = string.char;
	local v11 = string.sub;
	local v12 = string.gsub;
	local v13 = string.rep;
	local v14 = table.concat;
	local v15 = table.insert;
	local v16 = math.ldexp;
	local v17 = getfenv or function()
		return _ENV;
	end;
	local v18 = setmetatable;
	local v19 = pcall;
	local v20 = select;
	local v21 = unpack or table.unpack;
	local v22 = tonumber;
	local function v23(v28, v29, ...)
		local v30 = 0;
		local v31;
		local v32;
		local v33;
		local v34;
		local v35;
		local v36;
		local v37;
		local v38;
		local v39;
		local v40;
		local v41;
		local v42;
		while true do
			if (v30 == 3) then
				function v37()
					local v44 = 0;
					local v45;
					local v46;
					local v47;
					local v48;
					local v49;
					local v50;
					local v51;
					while true do
						if (v44 == 1) then
							v47 = nil;
							v48 = nil;
							v44 = 2;
						end
						if (v44 == 2) then
							v49 = nil;
							v50 = nil;
							v44 = 3;
						end
						if (v44 == 3) then
							v51 = nil;
							while true do
								local v99 = 0;
								while true do
									if (v99 == 1) then
										if (v45 == 0) then
											local v111 = 0;
											while true do
												if (v111 == 1) then
													v45 = 1;
													break;
												end
												if (v111 == 0) then
													v46 = v36();
													v47 = v36();
													v111 = 1;
												end
											end
										end
										if (v45 == 1) then
											local v112 = 0;
											while true do
												if (v112 == 1) then
													v45 = 2;
													break;
												end
												if (v112 == 0) then
													v48 = 1;
													v49 = (v33(v47, 1, 20) * (2 ^ 32)) + v46;
													v112 = 1;
												end
											end
										end
										break;
									end
									if (v99 == 0) then
										if (2 == v45) then
											local v113 = 0;
											while true do
												if (v113 == 1) then
													v45 = 3;
													break;
												end
												if (v113 == 0) then
													v50 = v33(v47, 21, 31);
													v51 = ((v33(v47, 32) == 1) and -1) or (932 - (857 + 74));
													v113 = 1;
												end
											end
										end
										if (v45 == 3) then
											local v114 = 0;
											while true do
												if (v114 == 0) then
													if (v50 == 0) then
														if (v49 == 0) then
															return v51 * (568 - (367 + 201));
														else
															local v159 = 0;
															local v160;
															while true do
																if (v159 == 0) then
																	v160 = 0;
																	while true do
																		if (v160 == 0) then
																			v50 = 1;
																			v48 = 0;
																			break;
																		end
																	end
																	break;
																end
															end
														end
													elseif (v50 == 2047) then
														return ((v49 == 0) and (v51 * (1 / 0))) or (v51 * NaN);
													end
													return v16(v51, v50 - (1950 - (214 + 713))) * (v48 + (v49 / (2 ^ 52)));
												end
											end
										end
										v99 = 1;
									end
								end
							end
							break;
						end
						if (v44 == 0) then
							v45 = 0;
							v46 = nil;
							v44 = 1;
						end
					end
				end
				v38 = nil;
				function v38(v52)
					local v53 = 0;
					local v54;
					local v55;
					local v56;
					while true do
						if (v53 == 1) then
							v56 = nil;
							while true do
								local v100 = 0;
								while true do
									if (v100 == 0) then
										if (1 == v54) then
											local v115 = 0;
											while true do
												if (v115 == 0) then
													v55 = v11(v28, v31, (v31 + v52) - 1);
													v31 = v31 + v52;
													v115 = 1;
												end
												if (v115 == 1) then
													v54 = 2;
													break;
												end
											end
										end
										if (v54 == 0) then
											local v116 = 0;
											while true do
												if (v116 == 0) then
													v55 = nil;
													if not v52 then
														local v158 = 0;
														while true do
															if (v158 == 0) then
																v52 = v36();
																if (v52 == (0 + 0)) then
																	return "";
																end
																break;
															end
														end
													end
													v116 = 1;
												end
												if (v116 == 1) then
													v54 = 1;
													break;
												end
											end
										end
										v100 = 1;
									end
									if (v100 == 1) then
										if (v54 == 2) then
											local v117 = 0;
											while true do
												if (v117 == 1) then
													v54 = 3;
													break;
												end
												if (0 == v117) then
													v56 = {};
													for v130 = 1, #v55 do
														v56[v130] = v10(v9(v11(v55, v130, v130)));
													end
													v117 = 1;
												end
											end
										end
										if (v54 == 3) then
											return v14(v56);
										end
										break;
									end
								end
							end
							break;
						end
						if (v53 == 0) then
							v54 = 0;
							v55 = nil;
							v53 = 1;
						end
					end
				end
				v39 = v36;
				v30 = 4;
			end
			if (v30 == 4) then
				v40 = nil;
				function v40(...)
					return {...}, v20("#", ...);
				end
				v41 = nil;
				function v41()
					local v57 = 0;
					local v58;
					local v59;
					local v60;
					local v61;
					local v62;
					local v63;
					local v64;
					while true do
						if (v57 == 0) then
							v58 = 0;
							v59 = nil;
							v57 = 1;
						end
						if (v57 == 1) then
							v60 = nil;
							v61 = nil;
							v57 = 2;
						end
						if (v57 == 2) then
							v62 = nil;
							v63 = nil;
							v57 = 3;
						end
						if (v57 == 3) then
							v64 = nil;
							while true do
								local v101 = 0;
								while true do
									if (0 == v101) then
										if (v58 == 1) then
											local v118 = 0;
											while true do
												if (v118 == 1) then
													for v132 = 1 + 0, v63 do
														local v133 = 0;
														local v134;
														local v135;
														local v136;
														while true do
															if (v133 == 0) then
																v134 = 0;
																v135 = nil;
																v133 = 1;
															end
															if (v133 == 1) then
																v136 = nil;
																while true do
																	if (v134 == 1) then
																		if (v135 == 1) then
																			v136 = v34() ~= 0;
																		elseif (v135 == (879 - (282 + 595))) then
																			v136 = v37();
																		elseif (v135 == 3) then
																			v136 = v38();
																		end
																		v64[v132] = v136;
																		break;
																	end
																	if (v134 == 0) then
																		local v166 = 0;
																		while true do
																			if (v166 == 1) then
																				v134 = 1;
																				break;
																			end
																			if (v166 == 0) then
																				v135 = v34();
																				v136 = nil;
																				v166 = 1;
																			end
																		end
																	end
																end
																break;
															end
														end
													end
													v62[3] = v34();
													v118 = 2;
												end
												if (v118 == 0) then
													v63 = v36();
													v64 = {};
													v118 = 1;
												end
												if (v118 == 2) then
													v58 = 2;
													break;
												end
											end
										end
										if (v58 == 0) then
											local v119 = 0;
											while true do
												if (v119 == 1) then
													v61 = {};
													v62 = {v59,v60,nil,v61};
													v119 = 2;
												end
												if (v119 == 2) then
													v58 = 1;
													break;
												end
												if (0 == v119) then
													v59 = {};
													v60 = {};
													v119 = 1;
												end
											end
										end
										v101 = 1;
									end
									if (v101 == 1) then
										if (v58 == 2) then
											local v120 = 0;
											while true do
												if (v120 == 0) then
													for v137 = 1, v36() do
														local v138 = 0;
														local v139;
														local v140;
														while true do
															if (v138 == 0) then
																v139 = 0;
																v140 = nil;
																v138 = 1;
															end
															if (v138 == 1) then
																while true do
																	if (v139 == 0) then
																		v140 = v34();
																		if (v33(v140, 1, 1) == 0) then
																			local v171 = 0;
																			local v172;
																			local v173;
																			local v174;
																			local v175;
																			while true do
																				if (v171 == 1) then
																					v174 = nil;
																					v175 = nil;
																					v171 = 2;
																				end
																				if (v171 == 0) then
																					v172 = 0;
																					v173 = nil;
																					v171 = 1;
																				end
																				if (v171 == 2) then
																					while true do
																						if (v172 == 3) then
																							if (v33(v174, 3, 3) == 1) then
																								v175[4] = v64[v175[4]];
																							end
																							v59[v137] = v175;
																							break;
																						end
																						if (0 == v172) then
																							local v180 = 0;
																							while true do
																								if (v180 == 1) then
																									v172 = 1;
																									break;
																								end
																								if (0 == v180) then
																									v173 = v33(v140, 2, 3);
																									v174 = v33(v140, 4, 1643 - (1523 + 114));
																									v180 = 1;
																								end
																							end
																						end
																						if (v172 == 2) then
																							local v181 = 0;
																							while true do
																								if (v181 == 0) then
																									if (v33(v174, 1, 1) == 1) then
																										v175[2] = v64[v175[2]];
																									end
																									if (v33(v174, 2, 2) == 1) then
																										v175[3] = v64[v175[3]];
																									end
																									v181 = 1;
																								end
																								if (v181 == 1) then
																									v172 = 3;
																									break;
																								end
																							end
																						end
																						if (v172 == 1) then
																							local v182 = 0;
																							while true do
																								if (v182 == 1) then
																									v172 = 2;
																									break;
																								end
																								if (v182 == 0) then
																									v175 = {v35(),v35(),nil,nil};
																									if (v173 == 0) then
																										local v224 = 0;
																										local v225;
																										while true do
																											if (v224 == 0) then
																												v225 = 0;
																												while true do
																													if (v225 == 0) then
																														v175[3] = v35();
																														v175[4] = v35();
																														break;
																													end
																												end
																												break;
																											end
																										end
																									elseif (v173 == 1) then
																										v175[3] = v36();
																									elseif (v173 == 2) then
																										v175[3] = v36() - (2 ^ (22 - 6));
																									elseif (v173 == 3) then
																										local v247 = 0;
																										local v248;
																										while true do
																											if (v247 == 0) then
																												v248 = 0;
																												while true do
																													if (v248 == 0) then
																														v175[3] = v36() - ((1067 - (68 + 997)) ^ 16);
																														v175[4] = v35();
																														break;
																													end
																												end
																												break;
																											end
																										end
																									end
																									v182 = 1;
																								end
																							end
																						end
																					end
																					break;
																				end
																			end
																		end
																		break;
																	end
																end
																break;
															end
														end
													end
													for v141 = 1, v36() do
														v60[v141 - 1] = v41();
													end
													v120 = 1;
												end
												if (v120 == 1) then
													return v62;
												end
											end
										end
										break;
									end
								end
							end
							break;
						end
					end
				end
				v30 = 5;
			end
			if (v30 == 1) then
				function v33(v65, v66, v67)
					if v67 then
						local v89 = 0;
						local v90;
						local v91;
						while true do
							if (v89 == 0) then
								v90 = 0;
								v91 = nil;
								v89 = 1;
							end
							if (v89 == 1) then
								while true do
									if (v90 == 0) then
										local v108 = 0;
										while true do
											if (v108 == 0) then
												v91 = (v65 / ((5 - 3) ^ (v66 - 1))) % (2 ^ (((v67 - 1) - (v66 - (2 - 1))) + 1));
												return v91 - (v91 % (1 - 0));
											end
										end
									end
								end
								break;
							end
						end
					else
						local v92 = 0;
						local v93;
						local v94;
						while true do
							if (v92 == 1) then
								while true do
									if (v93 == 0) then
										local v109 = 0;
										while true do
											if (v109 == 0) then
												v94 = 2 ^ (v66 - 1);
												return (((v65 % (v94 + v94)) >= v94) and 1) or 0;
											end
										end
									end
								end
								break;
							end
							if (v92 == 0) then
								v93 = 0;
								v94 = nil;
								v92 = 1;
							end
						end
					end
				end
				v34 = nil;
				function v34()
					local v68 = 0;
					local v69;
					local v70;
					while true do
						if (v68 == 1) then
							while true do
								local v102 = 0;
								while true do
									if (0 == v102) then
										if (v69 == 0) then
											local v121 = 0;
											while true do
												if (v121 == 1) then
													v69 = 1;
													break;
												end
												if (0 == v121) then
													v70 = v9(v28, v31, v31);
													v31 = v31 + 1;
													v121 = 1;
												end
											end
										end
										if (v69 == 1) then
											return v70;
										end
										break;
									end
								end
							end
							break;
						end
						if (v68 == 0) then
							v69 = 0;
							v70 = nil;
							v68 = 1;
						end
					end
				end
				v35 = nil;
				v30 = 2;
			end
			if (v30 == 5) then
				v42 = nil;
				function v42(v71, v72, v73)
					local v74 = 0;
					local v75;
					local v76;
					local v77;
					local v78;
					while true do
						if (v74 == 2) then
							while true do
								local v103 = 0;
								while true do
									if (v103 == 0) then
										if (1 == v75) then
											local v122 = 0;
											while true do
												if (v122 == 0) then
													v78 = v71[3];
													return function(...)
														local v143 = 0;
														local v144;
														local v145;
														local v146;
														local v147;
														local v148;
														local v149;
														local v150;
														local v151;
														local v152;
														local v153;
														local v154;
														local v155;
														local v156;
														local v157;
														while true do
															if (v143 == 3) then
																v155 = (v152 - v146) + 1;
																v156 = nil;
																v157 = nil;
																while true do
																	local v162 = 0;
																	local v163;
																	while true do
																		if (v162 == 0) then
																			v163 = 0;
																			while true do
																				if (v163 == 1) then
																					if (v157 <= 7) then
																						if (v157 <= 3) then
																							if (v157 <= (1 + 0)) then
																								if (v157 > 0) then
																									v154[v156[2]]();
																								else
																									local v185 = 0;
																									local v186;
																									local v187;
																									while true do
																										if (v185 == 1) then
																											while true do
																												if (v186 == 0) then
																													v187 = v156[2];
																													v154[v187] = v154[v187](v21(v154, v187 + 1, v149));
																													break;
																												end
																											end
																											break;
																										end
																										if (0 == v185) then
																											v186 = 0;
																											v187 = nil;
																											v185 = 1;
																										end
																									end
																								end
																							elseif (v157 > 2) then
																								do
																									return;
																								end
																							else
																								v154[v156[2]]();
																							end
																						elseif (v157 <= (2 + 3)) then
																							if (v157 > 4) then
																								v154[v156[2]] = v156[3] ~= 0;
																							else
																								v154[v156[959 - (892 + 65)]] = v156[3];
																							end
																						elseif (v157 > 6) then
																							local v191 = 0;
																							local v192;
																							local v193;
																							local v194;
																							while true do
																								if (0 == v191) then
																									v192 = 0;
																									v193 = nil;
																									v191 = 1;
																								end
																								if (v191 == 1) then
																									v194 = nil;
																									while true do
																										if (v192 == 1) then
																											v154[v193 + 1] = v194;
																											v154[v193] = v194[v156[4]];
																											break;
																										end
																										if (v192 == 0) then
																											local v238 = 0;
																											while true do
																												if (v238 == 0) then
																													v193 = v156[2];
																													v194 = v154[v156[3]];
																													v238 = 1;
																												end
																												if (v238 == 1) then
																													v192 = 1;
																													break;
																												end
																											end
																										end
																									end
																									break;
																								end
																							end
																						else
																							v154[v156[2]] = v73[v156[3]];
																						end
																					elseif (v157 <= (25 - 14)) then
																						if (v157 <= 9) then
																							if (v157 > 8) then
																								local v197 = 0;
																								local v198;
																								local v199;
																								while true do
																									if (v197 == 0) then
																										v198 = 0;
																										v199 = nil;
																										v197 = 1;
																									end
																									if (v197 == 1) then
																										while true do
																											if (v198 == 0) then
																												v199 = v156[2];
																												v154[v199] = v154[v199](v21(v154, v199 + 1, v149));
																												break;
																											end
																										end
																										break;
																									end
																								end
																							else
																								do
																									return;
																								end
																							end
																						elseif (v157 == 10) then
																							local v200 = 0;
																							local v201;
																							local v202;
																							local v203;
																							local v204;
																							local v205;
																							while true do
																								if (1 == v200) then
																									v203 = nil;
																									v204 = nil;
																									v200 = 2;
																								end
																								if (v200 == 2) then
																									v205 = nil;
																									while true do
																										if (v201 == 0) then
																											local v241 = 0;
																											while true do
																												if (v241 == 1) then
																													v201 = 1;
																													break;
																												end
																												if (v241 == 0) then
																													v202 = v156[3 - 1];
																													v203, v204 = v147(v154[v202](v21(v154, v202 + 1, v156[3])));
																													v241 = 1;
																												end
																											end
																										end
																										if (v201 == 2) then
																											for v249 = v202, v149 do
																												local v250 = 0;
																												while true do
																													if (v250 == 0) then
																														v205 = v205 + 1;
																														v154[v249] = v203[v205];
																														break;
																													end
																												end
																											end
																											break;
																										end
																										if (1 == v201) then
																											local v242 = 0;
																											while true do
																												if (v242 == 0) then
																													v149 = (v204 + v202) - 1;
																													v205 = 0 - 0;
																													v242 = 1;
																												end
																												if (v242 == 1) then
																													v201 = 2;
																													break;
																												end
																											end
																										end
																									end
																									break;
																								end
																								if (v200 == 0) then
																									v201 = 0;
																									v202 = nil;
																									v200 = 1;
																								end
																							end
																						else
																							v154[v156[2]] = v73[v156[3]];
																						end
																					elseif (v157 <= 13) then
																						if (v157 == 12) then
																							local v208 = 0;
																							local v209;
																							local v210;
																							while true do
																								if (v208 == 0) then
																									v209 = v156[352 - (87 + 263)];
																									v210 = v154[v156[3]];
																									v208 = 1;
																								end
																								if (v208 == 1) then
																									v154[v209 + 1] = v210;
																									v154[v209] = v210[v156[4]];
																									break;
																								end
																							end
																						else
																							v154[v156[2]] = v156[3];
																						end
																					elseif (v157 == 14) then
																						v154[v156[2]] = v156[3] ~= 0;
																					else
																						local v214 = 0;
																						local v215;
																						local v216;
																						local v217;
																						local v218;
																						local v219;
																						while true do
																							if (2 == v214) then
																								v219 = nil;
																								while true do
																									if (v215 == 1) then
																										local v243 = 0;
																										while true do
																											if (v243 == 0) then
																												v149 = (v218 + v216) - 1;
																												v219 = 0;
																												v243 = 1;
																											end
																											if (v243 == 1) then
																												v215 = 2;
																												break;
																											end
																										end
																									end
																									if (v215 == 2) then
																										for v251 = v216, v149 do
																											local v252 = 0;
																											local v253;
																											while true do
																												if (v252 == 0) then
																													v253 = 0;
																													while true do
																														if (v253 == 0) then
																															v219 = v219 + 1;
																															v154[v251] = v217[v219];
																															break;
																														end
																													end
																													break;
																												end
																											end
																										end
																										break;
																									end
																									if (v215 == 0) then
																										local v244 = 0;
																										while true do
																											if (v244 == 1) then
																												v215 = 1;
																												break;
																											end
																											if (v244 == 0) then
																												v216 = v156[2];
																												v217, v218 = v147(v154[v216](v21(v154, v216 + 1, v156[3])));
																												v244 = 1;
																											end
																										end
																									end
																								end
																								break;
																							end
																							if (v214 == 1) then
																								v217 = nil;
																								v218 = nil;
																								v214 = 2;
																							end
																							if (v214 == 0) then
																								v215 = 0;
																								v216 = nil;
																								v214 = 1;
																							end
																						end
																					end
																					v148 = v148 + 1;
																					break;
																				end
																				if (v163 == 0) then
																					local v176 = 0;
																					while true do
																						if (v176 == 1) then
																							v163 = 1;
																							break;
																						end
																						if (0 == v176) then
																							v156 = v144[v148];
																							v157 = v156[1];
																							v176 = 1;
																						end
																					end
																				end
																			end
																			break;
																		end
																	end
																end
																break;
															end
															if (1 == v143) then
																v148 = 4 - 3;
																v149 = -1;
																v150 = {};
																v151 = {...};
																v143 = 2;
															end
															if (v143 == 0) then
																v144 = v76;
																v145 = v77;
																v146 = v78;
																v147 = v40;
																v143 = 1;
															end
															if (v143 == 2) then
																v152 = v20("#", ...) - 1;
																v153 = {};
																v154 = {};
																for v164 = 0, v152 do
																	if (v164 >= v146) then
																		v150[v164 - v146] = v151[v164 + 1];
																	else
																		v154[v164] = v151[v164 + (118 - (32 + 85))];
																	end
																end
																v143 = 3;
															end
														end
													end;
												end
											end
										end
										if (v75 == 0) then
											local v123 = 0;
											while true do
												if (v123 == 0) then
													v76 = v71[1271 - (226 + 1044)];
													v77 = v71[2];
													v123 = 1;
												end
												if (v123 == 1) then
													v75 = 1;
													break;
												end
											end
										end
										break;
									end
								end
							end
							break;
						end
						if (v74 == 1) then
							v77 = nil;
							v78 = nil;
							v74 = 2;
						end
						if (v74 == 0) then
							v75 = 0;
							v76 = nil;
							v74 = 1;
						end
					end
				end
				return v42(v41(), {}, v29)(...);
			end
			if (2 == v30) then
				function v35()
					local v79 = 0;
					local v80;
					local v81;
					while true do
						if (v79 == 1) then
							return (v81 * (875 - (555 + 64))) + v80;
						end
						if (v79 == 0) then
							v80, v81 = v9(v28, v31, v31 + 2);
							v31 = v31 + (4 - 2);
							v79 = 1;
						end
					end
				end
				v36 = nil;
				function v36()
					local v82 = 0;
					local v83;
					local v84;
					local v85;
					local v86;
					local v87;
					while true do
						if (v82 == 0) then
							v83 = 0;
							v84 = nil;
							v82 = 1;
						end
						if (v82 == 2) then
							v87 = nil;
							while true do
								local v104 = 0;
								while true do
									if (0 == v104) then
										if (v83 == 0) then
											local v124 = 0;
											while true do
												if (0 == v124) then
													v84, v85, v86, v87 = v9(v28, v31, v31 + 3);
													v31 = v31 + 4;
													v124 = 1;
												end
												if (v124 == 1) then
													v83 = 1;
													break;
												end
											end
										end
										if (v83 == 1) then
											return (v87 * 16777216) + (v86 * 65536) + (v85 * 256) + v84;
										end
										break;
									end
								end
							end
							break;
						end
						if (v82 == 1) then
							v85 = nil;
							v86 = nil;
							v82 = 2;
						end
					end
				end
				v37 = nil;
				v30 = 3;
			end
			if (v30 == 0) then
				v31 = 1;
				v32 = nil;
				v28 = v12(v11(v28, 5), v7("\20\134", "\224\58\168\133\54\58\146"), function(v88)
					if (v9(v88, 2) == 79) then
						local v95 = 0;
						local v96;
						while true do
							if (v95 == 0) then
								v96 = 0;
								while true do
									if (v96 == 0) then
										local v110 = 0;
										while true do
											if (v110 == 0) then
												v32 = v8(v11(v88, 1, 1));
												return "";
											end
										end
									end
								end
								break;
							end
						end
					else
						local v97 = 0;
						local v98;
						while true do
							if (v97 == 0) then
								v98 = v10(v8(v88, 16));
								if v32 then
									local v105 = 0;
									local v106;
									local v107;
									while true do
										if (v105 == 0) then
											v106 = 0;
											v107 = nil;
											v105 = 1;
										end
										if (v105 == 1) then
											while true do
												local v125 = 0;
												while true do
													if (v125 == 0) then
														if (v106 == 1) then
															return v107;
														end
														if (v106 == 0) then
															local v161 = 0;
															while true do
																if (v161 == 0) then
																	v107 = v13(v98, v32);
																	v32 = nil;
																	v161 = 1;
																end
																if (1 == v161) then
																	v106 = 1;
																	break;
																end
															end
														end
														break;
													end
												end
											end
											break;
										end
									end
								else
									return v98;
								end
								break;
							end
						end
					end
				end);
				v33 = nil;
				v30 = 1;
			end
		end
	end
	v23(v7("\117\121\103\188\37\210\212\36\9\6\27\174\37\167\212\36\9\6\29\222\35\160\209\90\15\2\28\174\34\210\208\89\15\15\29\216\35\209\215\88\9\2\24\210\37\214\209\92\15\7\29\217\35\211\215\88\9\1\24\210\37\214\211\83\11\121\28\169\34\214\211\92\15\3\28\169\37\213\209\94\10\121\27\173\35\222\213\36\14\2\28\173\34\213\212\42\11\121\25\219\34\212\209\90\14\1\25\216\35\209\209\82\14\2\29\165\34\211\209\89\14\3\28\174\35\211\208\89\15\5\29\219\35\163\208\95\15\3\29\216\34\210\213\46\15\5\29\219\35\162\213\45\15\14\28\210\35\167\213\36\15\15\28\168\39\169\209\92\15\121\29\165\39\169\209\92\14\15\29\164\39\160\211\92\14\4\25\210\35\211\209\46\11\114\28\174\35\213\208\89\15\15\28\173\34\210\213\45\15\114\29\172\35\223\209\46\11\112\25\168\33\211\212\92\11\3\25\210\33\212\213\94\13\4\31\171\39\211\212\89\10\6\25\168\33\211\212\92\11\3\25\210\38\223\213\94\13\4\31\169\39\163\209\40\14\3\29\172\37\214\215\82\10\121\27\173\36\212\215\41\10\121\27\173\37\215\212\36\9\6\26\175\37\164\215\91\9\7\27\173\37\212\212\36\9\6\25\173\37\165\215\91\9\7\27\173\37\215\215\91\9\5\27\173\36\212\215\47\9\6\27\174\37\214\215\95\13\121\27\173\37\163\215\91\9\2\27\173\37\215\211\36\9\6\27\219\37\214\215\90\9\6\27\169\44\169\215\91\9\6\27\175\39\169\215\91\9\7\24\210\37\214\215\90\9\6\27\172\39\169\215\91\9\5\24\210\37\214\215\90\14\121\27\173", "\107\57\54\43\157\21\230\231"), v17(), ...);
end
