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
				for v44 = 1, #v24 do
					v6(v27, v0(v4(v1(v2(v24, v44, v44 + 1)), v1(v2(v25, 1 + (v44 % #v25), 1 + (v44 % #v25) + 1))) % 256));
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
		local v43;
		while true do
			if (v30 == 1) then
				v35 = nil;
				v36 = nil;
				v37 = nil;
				v38 = nil;
				v30 = 2;
			end
			if (2 == v30) then
				v39 = nil;
				v40 = nil;
				v41 = nil;
				v42 = nil;
				v30 = 3;
			end
			if (v30 == 0) then
				v31 = 0;
				v32 = nil;
				v33 = nil;
				v34 = nil;
				v30 = 1;
			end
			if (v30 == 3) then
				v43 = nil;
				while true do
					local v45 = 0;
					while true do
						if (2 == v45) then
							if (v31 == 5) then
								local v46 = 0;
								while true do
									if (v46 == 0) then
										v40 = v37;
										v41 = nil;
										v46 = 1;
									end
									if (v46 == 1) then
										function v41(...)
											return {...}, v20("#", ...);
										end
										v31 = 6;
										break;
									end
								end
							end
							if (v31 == 2) then
								local v47 = 0;
								while true do
									if (v47 == 0) then
										function v35()
											local v54 = 0;
											local v55;
											local v56;
											while true do
												if (v54 == 0) then
													v55 = 0;
													v56 = nil;
													v54 = 1;
												end
												if (1 == v54) then
													while true do
														local v109 = 0;
														while true do
															if (0 == v109) then
																if (v55 == 1) then
																	return v56;
																end
																if (v55 == 0) then
																	local v121 = 0;
																	while true do
																		if (v121 == 0) then
																			v56 = v9(v28, v32, v32);
																			v32 = v32 + 1;
																			v121 = 1;
																		end
																		if (v121 == 1) then
																			v55 = 1;
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
										end
										v36 = nil;
										v47 = 1;
									end
									if (v47 == 1) then
										function v36()
											local v57 = 0;
											local v58;
											local v59;
											local v60;
											while true do
												if (v57 == 1) then
													v60 = nil;
													while true do
														local v110 = 0;
														while true do
															if (v110 == 0) then
																if (0 == v58) then
																	local v122 = 0;
																	while true do
																		if (v122 == 0) then
																			v59, v60 = v9(v28, v32, v32 + 2);
																			v32 = v32 + (3 - 1);
																			v122 = 1;
																		end
																		if (v122 == 1) then
																			v58 = 1;
																			break;
																		end
																	end
																end
																if (1 == v58) then
																	return (v60 * 256) + v59;
																end
																break;
															end
														end
													end
													break;
												end
												if (v57 == 0) then
													v58 = 0;
													v59 = nil;
													v57 = 1;
												end
											end
										end
										v31 = 3;
										break;
									end
								end
							end
							v45 = 3;
						end
						if (v45 == 3) then
							if (v31 == 7) then
								local v48 = 0;
								while true do
									if (0 == v48) then
										function v43(v61, v62, v63)
											local v64 = 0;
											local v65;
											local v66;
											local v67;
											local v68;
											while true do
												if (2 == v64) then
													while true do
														local v111 = 0;
														while true do
															if (v111 == 0) then
																if (v65 == 1) then
																	local v123 = 0;
																	while true do
																		if (v123 == 0) then
																			v68 = v61[3];
																			return function(...)
																				local v140 = 0;
																				local v141;
																				local v142;
																				local v143;
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
																				while true do
																					if (v140 == 1) then
																						v144 = v41;
																						v145 = 1 + 0;
																						v146 = -1;
																						v140 = 2;
																					end
																					if (v140 == 3) then
																						v150 = {};
																						v151 = {};
																						for v169 = 0, v149 do
																							if (v169 >= v143) then
																								v147[v169 - v143] = v148[v169 + 1];
																							else
																								v151[v169] = v148[v169 + 1];
																							end
																						end
																						v140 = 4;
																					end
																					if (v140 == 5) then
																						while true do
																							local v170 = 0;
																							local v171;
																							while true do
																								if (v170 == 0) then
																									v171 = 0;
																									while true do
																										if (0 == v171) then
																											local v184 = 0;
																											while true do
																												if (v184 == 0) then
																													v153 = v141[v145];
																													v154 = v153[1];
																													v184 = 1;
																												end
																												if (1 == v184) then
																													v171 = 1;
																													break;
																												end
																											end
																										end
																										if (v171 == 1) then
																											if (v154 <= 7) then
																												if (v154 <= 3) then
																													if (v154 <= 1) then
																														if (v154 > 0) then
																															do
																																return;
																															end
																														else
																															v151[v153[2]]();
																														end
																													elseif (v154 == 2) then
																														v151[v153[2 - 0]] = v63[v153[3]];
																													else
																														do
																															return;
																														end
																													end
																												elseif (v154 <= 5) then
																													if (v154 > 4) then
																														local v195 = 0;
																														local v196;
																														local v197;
																														while true do
																															if (v195 == 0) then
																																v196 = 0;
																																v197 = nil;
																																v195 = 1;
																															end
																															if (v195 == 1) then
																																while true do
																																	if (0 == v196) then
																																		v197 = v153[1067 - (68 + 997)];
																																		v151[v197] = v151[v197](v21(v151, v197 + 1, v146));
																																		break;
																																	end
																																end
																																break;
																															end
																														end
																													else
																														v151[v153[2]] = v153[1273 - (226 + 1044)];
																													end
																												elseif (v154 == 6) then
																													v151[v153[2]] = v153[3] ~= 0;
																												else
																													v151[v153[2]] = v153[12 - 9] ~= 0;
																												end
																											elseif (v154 <= 11) then
																												if (v154 <= 9) then
																													if (v154 == 8) then
																														local v202 = 0;
																														local v203;
																														local v204;
																														local v205;
																														local v206;
																														local v207;
																														while true do
																															if (v202 == 2) then
																																v207 = nil;
																																while true do
																																	if (v203 == 0) then
																																		local v243 = 0;
																																		while true do
																																			if (v243 == 0) then
																																				v204 = v153[2];
																																				v205, v206 = v144(v151[v204](v21(v151, v204 + 1, v153[3])));
																																				v243 = 1;
																																			end
																																			if (v243 == 1) then
																																				v203 = 1;
																																				break;
																																			end
																																		end
																																	end
																																	if (v203 == 2) then
																																		for v253 = v204, v146 do
																																			local v254 = 0;
																																			local v255;
																																			while true do
																																				if (v254 == 0) then
																																					v255 = 0;
																																					while true do
																																						if (v255 == 0) then
																																							v207 = v207 + 1;
																																							v151[v253] = v205[v207];
																																							break;
																																						end
																																					end
																																					break;
																																				end
																																			end
																																		end
																																		break;
																																	end
																																	if (v203 == 1) then
																																		local v244 = 0;
																																		while true do
																																			if (v244 == 1) then
																																				v203 = 2;
																																				break;
																																			end
																																			if (v244 == 0) then
																																				v146 = (v206 + v204) - 1;
																																				v207 = 0;
																																				v244 = 1;
																																			end
																																		end
																																	end
																																end
																																break;
																															end
																															if (v202 == 0) then
																																v203 = 0;
																																v204 = nil;
																																v202 = 1;
																															end
																															if (v202 == 1) then
																																v205 = nil;
																																v206 = nil;
																																v202 = 2;
																															end
																														end
																													else
																														local v208 = 0;
																														local v209;
																														local v210;
																														while true do
																															if (v208 == 0) then
																																v209 = 0;
																																v210 = nil;
																																v208 = 1;
																															end
																															if (v208 == 1) then
																																while true do
																																	if (v209 == 0) then
																																		v210 = v153[2];
																																		v151[v210] = v151[v210](v21(v151, v210 + 1, v146));
																																		break;
																																	end
																																end
																																break;
																															end
																														end
																													end
																												elseif (v154 == (127 - (32 + 85))) then
																													v151[v153[2]]();
																												else
																													v151[v153[2]] = v153[3];
																												end
																											elseif (v154 <= 13) then
																												if (v154 == 12) then
																													local v213 = 0;
																													local v214;
																													local v215;
																													local v216;
																													local v217;
																													local v218;
																													while true do
																														if (v213 == 1) then
																															v216 = nil;
																															v217 = nil;
																															v213 = 2;
																														end
																														if (v213 == 2) then
																															v218 = nil;
																															while true do
																																if (0 == v214) then
																																	local v247 = 0;
																																	while true do
																																		if (v247 == 0) then
																																			v215 = v153[2];
																																			v216, v217 = v144(v151[v215](v21(v151, v215 + 1, v153[3])));
																																			v247 = 1;
																																		end
																																		if (v247 == 1) then
																																			v214 = 1;
																																			break;
																																		end
																																	end
																																end
																																if (v214 == 2) then
																																	for v256 = v215, v146 do
																																		local v257 = 0;
																																		local v258;
																																		while true do
																																			if (v257 == 0) then
																																				v258 = 0;
																																				while true do
																																					if (v258 == 0) then
																																						v218 = v218 + 1 + 0;
																																						v151[v256] = v216[v218];
																																						break;
																																					end
																																				end
																																				break;
																																			end
																																		end
																																	end
																																	break;
																																end
																																if (v214 == 1) then
																																	local v248 = 0;
																																	while true do
																																		if (v248 == 1) then
																																			v214 = 2;
																																			break;
																																		end
																																		if (v248 == 0) then
																																			v146 = (v217 + v215) - 1;
																																			v218 = 0;
																																			v248 = 1;
																																		end
																																	end
																																end
																															end
																															break;
																														end
																														if (0 == v213) then
																															v214 = 0;
																															v215 = nil;
																															v213 = 1;
																														end
																													end
																												else
																													v151[v153[2]] = v63[v153[3]];
																												end
																											elseif (v154 > 14) then
																												local v221 = 0;
																												local v222;
																												local v223;
																												local v224;
																												while true do
																													if (1 == v221) then
																														v224 = nil;
																														while true do
																															if (v222 == 0) then
																																local v249 = 0;
																																while true do
																																	if (v249 == 0) then
																																		v223 = v153[2];
																																		v224 = v151[v153[3]];
																																		v249 = 1;
																																	end
																																	if (v249 == 1) then
																																		v222 = 1;
																																		break;
																																	end
																																end
																															end
																															if (v222 == 1) then
																																v151[v223 + 1] = v224;
																																v151[v223] = v224[v153[4]];
																																break;
																															end
																														end
																														break;
																													end
																													if (v221 == 0) then
																														v222 = 0;
																														v223 = nil;
																														v221 = 1;
																													end
																												end
																											else
																												local v225 = 0;
																												local v226;
																												local v227;
																												while true do
																													if (v225 == 0) then
																														v226 = v153[2];
																														v227 = v151[v153[1 + 2]];
																														v225 = 1;
																													end
																													if (v225 == 1) then
																														v151[v226 + 1] = v227;
																														v151[v226] = v227[v153[4]];
																														break;
																													end
																												end
																											end
																											v145 = v145 + 1;
																											break;
																										end
																									end
																									break;
																								end
																							end
																						end
																						break;
																					end
																					if (2 == v140) then
																						v147 = {};
																						v148 = {...};
																						v149 = v20("#", ...) - 1;
																						v140 = 3;
																					end
																					if (v140 == 4) then
																						v152 = (v149 - v143) + 1;
																						v153 = nil;
																						v154 = nil;
																						v140 = 5;
																					end
																					if (v140 == 0) then
																						v141 = v66;
																						v142 = v67;
																						v143 = v68;
																						v140 = 1;
																					end
																				end
																			end;
																		end
																	end
																end
																if (v65 == 0) then
																	local v124 = 0;
																	while true do
																		if (1 == v124) then
																			v65 = 1;
																			break;
																		end
																		if (v124 == 0) then
																			v66 = v61[1];
																			v67 = v61[2];
																			v124 = 1;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
												if (1 == v64) then
													v67 = nil;
													v68 = nil;
													v64 = 2;
												end
												if (v64 == 0) then
													v65 = 0;
													v66 = nil;
													v64 = 1;
												end
											end
										end
										return v43(v42(), {}, v29)(...);
									end
								end
							end
							if (v31 == 0) then
								local v49 = 0;
								while true do
									if (v49 == 0) then
										v32 = 1;
										v33 = nil;
										v49 = 1;
									end
									if (1 == v49) then
										v28 = v12(v11(v28, 5), v7("\2\173", "\225\44\131\25\131\29\43\179"), function(v69)
											if (v9(v69, 2) == 79) then
												local v99 = 0;
												local v100;
												while true do
													if (0 == v99) then
														v100 = 0;
														while true do
															if (v100 == 0) then
																local v119 = 0;
																while true do
																	if (v119 == 0) then
																		v33 = v8(v11(v69, 1, 1));
																		return "";
																	end
																end
															end
														end
														break;
													end
												end
											else
												local v101 = 0;
												local v102;
												local v103;
												while true do
													if (v101 == 0) then
														v102 = 0;
														v103 = nil;
														v101 = 1;
													end
													if (v101 == 1) then
														while true do
															if (v102 == 0) then
																v103 = v10(v8(v69, 49 - 33));
																if v33 then
																	local v133 = 0;
																	local v134;
																	local v135;
																	while true do
																		if (v133 == 1) then
																			while true do
																				local v166 = 0;
																				while true do
																					if (0 == v166) then
																						if (v134 == 0) then
																							local v176 = 0;
																							while true do
																								if (v176 == 1) then
																									v134 = 1;
																									break;
																								end
																								if (v176 == 0) then
																									v135 = v13(v103, v33);
																									v33 = nil;
																									v176 = 1;
																								end
																							end
																						end
																						if (v134 == 1) then
																							return v135;
																						end
																						break;
																					end
																				end
																			end
																			break;
																		end
																		if (v133 == 0) then
																			v134 = 0;
																			v135 = nil;
																			v133 = 1;
																		end
																	end
																else
																	return v103;
																end
																break;
															end
														end
														break;
													end
												end
											end
										end);
										v31 = 1;
										break;
									end
								end
							end
							break;
						end
						if (v45 == 0) then
							if (v31 == 6) then
								local v50 = 0;
								while true do
									if (v50 == 1) then
										v43 = nil;
										v31 = 7;
										break;
									end
									if (v50 == 0) then
										v42 = nil;
										function v42()
											local v70 = 0;
											local v71;
											local v72;
											local v73;
											local v74;
											local v75;
											local v76;
											local v77;
											while true do
												if (v70 == 1) then
													v73 = nil;
													v74 = nil;
													v70 = 2;
												end
												if (v70 == 2) then
													v75 = nil;
													v76 = nil;
													v70 = 3;
												end
												if (v70 == 3) then
													v77 = nil;
													while true do
														local v112 = 0;
														while true do
															if (v112 == 0) then
																if (v71 == 2) then
																	local v125 = 0;
																	while true do
																		if (v125 == 0) then
																			for v155 = 1, v37() do
																				local v156 = 0;
																				local v157;
																				local v158;
																				while true do
																					if (v156 == 1) then
																						while true do
																							if (v157 == 0) then
																								v158 = v35();
																								if (v34(v158, 1, 1) == 0) then
																									local v179 = 0;
																									local v180;
																									local v181;
																									local v182;
																									local v183;
																									while true do
																										if (v179 == 2) then
																											while true do
																												if (v180 == 2) then
																													local v187 = 0;
																													while true do
																														if (v187 == 0) then
																															if (v34(v182, 1, 1) == 1) then
																																v183[2] = v77[v183[2]];
																															end
																															if (v34(v182, 1 + 1, 2) == 1) then
																																v183[880 - (282 + 595)] = v77[v183[3]];
																															end
																															v187 = 1;
																														end
																														if (v187 == 1) then
																															v180 = 3;
																															break;
																														end
																													end
																												end
																												if (v180 == 1) then
																													local v188 = 0;
																													while true do
																														if (v188 == 0) then
																															v183 = {v36(),v36(),nil,nil};
																															if (v181 == 0) then
																																local v232 = 0;
																																local v233;
																																while true do
																																	if (v232 == 0) then
																																		v233 = 0;
																																		while true do
																																			if (v233 == 0) then
																																				v183[1 + 2] = v36();
																																				v183[4] = v36();
																																				break;
																																			end
																																		end
																																		break;
																																	end
																																end
																															elseif (v181 == 1) then
																																v183[3] = v37();
																															elseif (v181 == 2) then
																																v183[3] = v37() - (2 ^ 16);
																															elseif (v181 == 3) then
																																local v261 = 0;
																																while true do
																																	if (v261 == 0) then
																																		v183[3] = v37() - (2 ^ 16);
																																		v183[4] = v36();
																																		break;
																																	end
																																end
																															end
																															v188 = 1;
																														end
																														if (v188 == 1) then
																															v180 = 2;
																															break;
																														end
																													end
																												end
																												if (v180 == 0) then
																													local v189 = 0;
																													while true do
																														if (1 == v189) then
																															v180 = 1;
																															break;
																														end
																														if (v189 == 0) then
																															v181 = v34(v158, 933 - (857 + 74), 3);
																															v182 = v34(v158, 4, 574 - (367 + 201));
																															v189 = 1;
																														end
																													end
																												end
																												if (v180 == 3) then
																													if (v34(v182, 3, 3) == 1) then
																														v183[4] = v77[v183[1641 - (1523 + 114)]];
																													end
																													v72[v155] = v183;
																													break;
																												end
																											end
																											break;
																										end
																										if (v179 == 0) then
																											v180 = 0;
																											v181 = nil;
																											v179 = 1;
																										end
																										if (v179 == 1) then
																											v182 = nil;
																											v183 = nil;
																											v179 = 2;
																										end
																									end
																								end
																								break;
																							end
																						end
																						break;
																					end
																					if (v156 == 0) then
																						v157 = 0;
																						v158 = nil;
																						v156 = 1;
																					end
																				end
																			end
																			for v159 = 1, v37() do
																				v73[v159 - 1] = v42();
																			end
																			v125 = 1;
																		end
																		if (v125 == 1) then
																			return v75;
																		end
																	end
																end
																if (v71 == 1) then
																	local v126 = 0;
																	while true do
																		if (v126 == 1) then
																			for v161 = 1, v76 do
																				local v162 = 0;
																				local v163;
																				local v164;
																				local v165;
																				while true do
																					if (v162 == 0) then
																						v163 = 0;
																						v164 = nil;
																						v162 = 1;
																					end
																					if (v162 == 1) then
																						v165 = nil;
																						while true do
																							if (v163 == 1) then
																								if (v164 == 1) then
																									v165 = v35() ~= 0;
																								elseif (v164 == 2) then
																									v165 = v38();
																								elseif (v164 == 3) then
																									v165 = v39();
																								end
																								v77[v161] = v165;
																								break;
																							end
																							if (0 == v163) then
																								local v178 = 0;
																								while true do
																									if (v178 == 1) then
																										v163 = 1;
																										break;
																									end
																									if (v178 == 0) then
																										v164 = v35();
																										v165 = nil;
																										v178 = 1;
																									end
																								end
																							end
																						end
																						break;
																					end
																				end
																			end
																			v75[3] = v35();
																			v126 = 2;
																		end
																		if (0 == v126) then
																			v76 = v37();
																			v77 = {};
																			v126 = 1;
																		end
																		if (v126 == 2) then
																			v71 = 2;
																			break;
																		end
																	end
																end
																v112 = 1;
															end
															if (v112 == 1) then
																if (v71 == 0) then
																	local v127 = 0;
																	while true do
																		if (v127 == 0) then
																			v72 = {};
																			v73 = {};
																			v127 = 1;
																		end
																		if (v127 == 1) then
																			v74 = {};
																			v75 = {v72,v73,nil,v74};
																			v127 = 2;
																		end
																		if (v127 == 2) then
																			v71 = 1;
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
												if (v70 == 0) then
													v71 = 0;
													v72 = nil;
													v70 = 1;
												end
											end
										end
										v50 = 1;
									end
								end
							end
							if (v31 == 3) then
								local v51 = 0;
								while true do
									if (v51 == 0) then
										v37 = nil;
										function v37()
											local v78 = 0;
											local v79;
											local v80;
											local v81;
											local v82;
											local v83;
											while true do
												if (v78 == 2) then
													v83 = nil;
													while true do
														local v113 = 0;
														while true do
															if (v113 == 0) then
																if (v79 == 0) then
																	local v128 = 0;
																	while true do
																		if (v128 == 1) then
																			v79 = 1;
																			break;
																		end
																		if (v128 == 0) then
																			v80, v81, v82, v83 = v9(v28, v32, v32 + 3);
																			v32 = v32 + 4;
																			v128 = 1;
																		end
																	end
																end
																if (1 == v79) then
																	return (v83 * (43216383 - 26439167)) + (v82 * 65536) + (v81 * 256) + v80;
																end
																break;
															end
														end
													end
													break;
												end
												if (v78 == 1) then
													v81 = nil;
													v82 = nil;
													v78 = 2;
												end
												if (v78 == 0) then
													v79 = 0;
													v80 = nil;
													v78 = 1;
												end
											end
										end
										v51 = 1;
									end
									if (v51 == 1) then
										v38 = nil;
										v31 = 4;
										break;
									end
								end
							end
							v45 = 1;
						end
						if (v45 == 1) then
							if (v31 == 4) then
								local v52 = 0;
								while true do
									if (v52 == 0) then
										function v38()
											local v84 = 0;
											local v85;
											local v86;
											local v87;
											local v88;
											local v89;
											local v90;
											local v91;
											while true do
												if (v84 == 3) then
													v91 = nil;
													while true do
														local v114 = 0;
														while true do
															if (v114 == 1) then
																if (0 == v85) then
																	local v129 = 0;
																	while true do
																		if (v129 == 0) then
																			v86 = v37();
																			v87 = v37();
																			v129 = 1;
																		end
																		if (1 == v129) then
																			v85 = 1;
																			break;
																		end
																	end
																end
																if (2 == v85) then
																	local v130 = 0;
																	while true do
																		if (0 == v130) then
																			v90 = v34(v87, 21, 31);
																			v91 = ((v34(v87, 32) == 1) and -1) or 1;
																			v130 = 1;
																		end
																		if (v130 == 1) then
																			v85 = 3;
																			break;
																		end
																	end
																end
																break;
															end
															if (v114 == 0) then
																if (3 == v85) then
																	local v131 = 0;
																	while true do
																		if (v131 == 0) then
																			if (v90 == 0) then
																				if (v89 == 0) then
																					return v91 * 0;
																				else
																					local v167 = 0;
																					local v168;
																					while true do
																						if (v167 == 0) then
																							v168 = 0;
																							while true do
																								if (v168 == 0) then
																									v90 = 1;
																									v88 = 0;
																									break;
																								end
																							end
																							break;
																						end
																					end
																				end
																			elseif (v90 == 2047) then
																				return ((v89 == 0) and (v91 * (1 / 0))) or (v91 * NaN);
																			end
																			return v16(v91, v90 - 1023) * (v88 + (v89 / (2 ^ (671 - (555 + 64)))));
																		end
																	end
																end
																if (1 == v85) then
																	local v132 = 0;
																	while true do
																		if (v132 == 0) then
																			v88 = 1;
																			v89 = (v34(v87, 1, 20) * (2 ^ 32)) + v86;
																			v132 = 1;
																		end
																		if (v132 == 1) then
																			v85 = 2;
																			break;
																		end
																	end
																end
																v114 = 1;
															end
														end
													end
													break;
												end
												if (v84 == 1) then
													v87 = nil;
													v88 = nil;
													v84 = 2;
												end
												if (v84 == 0) then
													v85 = 0;
													v86 = nil;
													v84 = 1;
												end
												if (v84 == 2) then
													v89 = nil;
													v90 = nil;
													v84 = 3;
												end
											end
										end
										v39 = nil;
										v52 = 1;
									end
									if (v52 == 1) then
										function v39(v92)
											local v93 = 0;
											local v94;
											local v95;
											while true do
												if (v93 == 1) then
													v94 = v11(v28, v32, (v32 + v92) - 1);
													v32 = v32 + v92;
													v93 = 2;
												end
												if (v93 == 0) then
													v94 = nil;
													if not v92 then
														local v117 = 0;
														local v118;
														while true do
															if (v117 == 0) then
																v118 = 0;
																while true do
																	if (v118 == 0) then
																		v92 = v37();
																		if (v92 == 0) then
																			return "";
																		end
																		break;
																	end
																end
																break;
															end
														end
													end
													v93 = 1;
												end
												if (v93 == 3) then
													return v14(v95);
												end
												if (v93 == 2) then
													v95 = {};
													for v115 = 1, #v94 do
														v95[v115] = v10(v9(v11(v94, v115, v115)));
													end
													v93 = 3;
												end
											end
										end
										v31 = 5;
										break;
									end
								end
							end
							if (v31 == 1) then
								local v53 = 0;
								while true do
									if (v53 == 0) then
										v34 = nil;
										function v34(v96, v97, v98)
											if v98 then
												local v104 = 0;
												local v105;
												while true do
													if (v104 == 0) then
														v105 = (v96 / (2 ^ (v97 - 1))) % (2 ^ (((v98 - 1) - (v97 - 1)) + 1));
														return v105 - (v105 % 1);
													end
												end
											else
												local v106 = 0;
												local v107;
												local v108;
												while true do
													if (v106 == 1) then
														while true do
															if (v107 == 0) then
																local v120 = 0;
																while true do
																	if (0 == v120) then
																		v108 = 2 ^ (v97 - (2 - 1));
																		return (((v96 % (v108 + v108)) >= v108) and 1) or 0;
																	end
																end
															end
														end
														break;
													end
													if (v106 == 0) then
														v107 = 0;
														v108 = nil;
														v106 = 1;
													end
												end
											end
										end
										v53 = 1;
									end
									if (1 == v53) then
										v35 = nil;
										v31 = 2;
										break;
									end
								end
							end
							v45 = 2;
						end
					end
				end
				break;
			end
		end
	end
	v23(v7("\55\96\96\252\137\116\108\99\75\31\28\238\137\1\108\99\75\31\26\158\143\6\105\29\77\27\27\238\142\116\104\30\77\22\26\152\143\119\111\31\75\27\31\146\137\112\105\27\77\30\26\153\143\117\111\31\75\24\31\146\137\112\107\20\73\96\27\233\142\112\107\27\77\26\27\233\137\115\105\24\72\96\28\237\143\120\109\99\76\27\27\237\142\115\108\109\73\96\30\155\142\114\105\29\76\24\30\152\143\119\105\21\76\27\26\229\142\117\105\30\76\26\27\238\143\117\104\30\77\28\26\155\143\5\104\24\77\26\26\152\142\116\109\105\77\28\26\155\143\4\109\106\77\23\27\146\143\1\109\99\77\22\27\232\139\15\105\27\77\96\26\229\139\15\105\27\76\22\26\228\139\6\107\27\76\29\30\146\143\117\105\105\73\107\27\238\143\115\104\30\77\22\27\237\142\116\109\106\77\107\26\236\143\121\105\105\73\105\30\232\141\117\108\27\73\26\30\146\141\114\109\25\79\29\24\235\139\117\107\25\72\25\30\232\138\121\108\26\73\26\24\239\138\112\106\25\79\22\30\152\143\3\104\25\77\30\28\237\137\121\108\99\75\31\29\239\137\114\108\99\75\31\28\236\138\15\111\28\74\29\28\239\137\112\111\29\75\31\28\239\138\15\111\28\73\31\28\155\137\112\111\29\75\31\28\236\137\112\111\31\75\31\29\239\137\116\111\28\75\28\28\237\137\116\107\99\75\31\28\235\137\112\111\24\75\31\28\236\141\15\111\28\75\23\28\237\137\113\111\28\75\27\24\146\137\112\111\21\78\96\28\237\137\114\105\99\75\31\28\236\137\112\111\29\73\96\28\237\137\115\108\99\75\31\28\236\142\15\111\28", "\44\123\47\44\221\185\64\95"), v17(), ...);
end
