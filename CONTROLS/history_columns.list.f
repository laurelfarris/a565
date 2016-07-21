! history_columns.list -- determines the contents of star history logs
! you can use a non-standard version by setting history_columns_file in your inlist

! units are cgs unless otherwise noted.

! reorder the following names as desired to reorder columns.
! comment out the name to omit a column (fewer columns => less IO => faster running).
! remove '!' to restore a column.

! if you have a situation where you want a non-standard set of columns,
! make a copy of this file, edit as desired, and give the new filename in your inlist
! as history_columns_file.   if you are just adding columns, you can 'include' this file,
! and just list the additions in your file.   note: to include the standard default
! version, use include '' -- the 0 length string means include the default file.

! blank lines and comments can be used freely.
! if a column name appears more than once in the list, only the first occurrence is used.

! if you need to have something added to the list of options, let me know....


! the first few lines of the log file contain a few items:
   
   ! version_number -- for the version of mesa being used
   ! burn_min1 -- 1st limit for reported burning, in erg/g/s
   ! burn_min2 -- 2nd limit for reported burning, in erg/g/s


! note: you can include another list by doing
!        include 'filename'
!        include '' means include the default standard list file


! the following lines of the log file contain info about 1 model per row
   
   ! some general info about the model
   
      model_number ! counting from the start of the run
      star_age ! elapsed simulated time in years since the start of the run
      !star_age_sec ! elapsed simulated time in seconds since the start of the run
      !star_age_min ! elapsed simulated time in minutes since the start of the run
      !star_age_hr ! elapsed simulated time in hours since the start of the run
      !star_age_day ! elapsed simulated time in days since the start of the run
      
      !log_star_age
      !log_star_age_sec
      star_mass ! in Msun units
      !log_star_mass
      
      !time_step ! timestep in years since previous model
      !time_step_sec ! timestep in seconds since previous model
      log_dt ! log10 time_step in years
      !log_dt_sec ! log10 time_step in seconds
      
      !star_gravitational_mass ! star_mass is baryonic mass
      !star_mass_grav_div_mass

      !delta_mass ! star_mass - initial_mass in Msun units
      log_xmstar ! log10 mass exterior to M_center (grams)
      !star_mdot ! d(star_mass)/dt (in msolar per year)
      log_abs_mdot ! log10(abs(star_mdot)) (in msolar per year)
      num_zones ! number of zones in the model
      !species ! size of net
      !log_total_angular_momentum
      !total_rotational_energy
      !log_total_rotational_energy
      
      !m_center
      !r_center
      !l_center
      !v_center
   
   ! mixing regions
      
      mass_conv_core ! (Msun) mass coord of top of convective core.  0 if core is not convective
      
      
      
      !  mx1 refers to the largest (by mass) convective region.
      !  mx2 is the 2nd largest.

      !  conv_mx1_top and conv_mx1_bot are the region where mixing_type == convective_mixing.
      !  mx1_top and mx1_bot are the extent of all kinds of mixing, convective and other.
      
      ! values are m/Mstar
      conv_mx1_top
      conv_mx1_bot
      conv_mx2_top
      conv_mx2_bot
      mx1_top
      mx1_bot
      mx2_top
      mx2_bot
      
      ! radius -- values are radii in Rsun units
      !conv_mx1_top_r
      !conv_mx1_bot_r
      !conv_mx2_top_r
      !conv_mx2_bot_r
      !mx1_top_r
      !mx1_bot_r
      !mx2_top_r
      !mx2_bot_r
      
      ! you might want to get a more complete list of mixing regions by using the following
      
      !mixing_regions <integer> ! note: this includes regions where the mixing type is no_mixing.
      
         ! the <integer> is the number of regions to report
         ! there will be 2*<integer> columns for this in the log file, 2 for each region.
         ! the first column for a region gives the mixing type as defined in mlt/public/mlt_def.
         
         ! the second column for a region gives the m/mstar location of the top of the region
         ! entries for extra columns after the last region in the star will have an invalid mixing_type value of -1.
         ! mstar is the total mass of the star, so these locations range from 0 to 1
         ! all regions are include starting from the center, so the bottom of one region
         ! is the top of the previous one.  since we start at the center, the bottom of the 1st region is 0.
         
         ! the columns in the log file will have names like 'mix_type_1' and 'mix_qtop_1'
         
         ! if the star has too many regions to report them all,
         ! the smallest regions will be merged with neighbors for reporting purposes only.

      
      !mix_relr_regions <integer> 
         ! same as above, but locations given as r/rstar instead of m/mstar.
         ! the columns in the log file will have names like 'mix_relr_type_1' and 'mix_relr_top_1'
      
   ! regions of strong nuclear burning
   
      ! 2 zones where eps_nuc > burn_min1 erg/g/s
      ! for each zone have 4 numbers: start1, start2, end2, end1
      ! start1 is mass of inner edge where first goes > burn_min1 (or -20 if none such)
      ! start2 is mass of inner edge where first zone reaches burn_min2 erg/g/sec (or -20 if none such)
      ! end2 is mass of outer edge where first zone drops back below burn_min2 erg/g/s
      ! end1 is mass of outer edge where first zone ends (i.e. eps_nuc < burn_min1)
      ! similar for the second zone
   
      epsnuc_M_1 ! start1 for 1st zone
      epsnuc_M_2 ! start2
      epsnuc_M_3 ! end2
      epsnuc_M_4 ! end1
      
      epsnuc_M_5 ! start1 for 2nd zone
      epsnuc_M_6 ! start2
      epsnuc_M_7 ! end2
      epsnuc_M_8 ! end1


      ! you might want to get a more complete list of burning regions by using the following
      
      !burning_regions <integer>
         ! the <integer> is the number of regions to report
         ! there will be 2*<integer> columns for this in the log file, 2 for each region.
         ! the first column for a region gives int(sign(val)*log10(max(1,abs(val))))
            ! where val = ergs/gm/sec nuclear energy minus all neutrino losses.
         ! the second column for a region gives the q location of the top of the region
         ! entries for extra columns after the last region in the star will have a value of -9999
         ! all regions are included starting from the center, so the bottom of one region
         ! is the top of the previous one. 
         ! since we start at the center, the bottom of the 1st region is q=0 and top of last is q=1.
         
         ! the columns in the log file will have names like 'burn_type_1' and 'burn_qtop_1'

         
         ! if the star has too many regions to report them all,
         ! the smallest regions will be merged with neighbors for reporting purposes only.
       


      
   ! conditions at base of largest convection zone (by mass)
      !cz_bot_mass ! mass coordinate of base (Msun)
      !cz_mass ! mass coordinate of base (Msun) -- same as cz_bot_mass
      !cz_log_xmass ! mass exterior to base (g)
      !cz_log_xmsun ! mass exterior to base (Msun)
      !cz_xm ! mass exterior to base (Msun)
      !cz_logT
      !cz_logRho
      !cz_logP
      !cz_bot_radius ! Rsun
      !cz_log_column_depth
      !cz_log_radial_depth
      !cz_luminosity ! Lsun
      !cz_opacity
      !cz_log_tau
      !cz_eta
      !cz_log_eps_nuc ! log10(ergs/g/s)
      !cz_t_heat ! Cp*T/eps_nuc (seconds)
      
      !cz_csound
      !cz_scale_height
      !cz_grav
      
      !cz_omega
      !cz_omega_div_omega_crit
      
      !cz_zone
      
   ! mass fractions at base of largest convection zone (by mass)
      !cz_log_xa h1
      !cz_log_xa he4



      
   ! conditions at top of largest convection zone (by mass)
      !cz_top_mass ! mass coordinate of top (Msun)
      !cz_top_log_xmass ! mass exterior to top (g)
      !cz_top_log_xmsun ! mass exterior to top (Msun)
      !cz_top_xm ! mass exterior to top (Msun)
      !cz_top_logT
      !cz_top_logRho
      !cz_top_logP
      !cz_top_radius ! Rsun
      !cz_top_log_column_depth
      !cz_top_log_radial_depth
      !cz_top_luminosity ! Lsun
      !cz_top_opacity
      !cz_top_log_tau
      !cz_top_eta
      !cz_top_log_eps_nuc ! log10(ergs/g/s)
      !cz_top_t_heat ! Cp*T/eps_nuc (seconds)
      
      !cz_top_csound
      !cz_top_scale_height
      !cz_top_grav
      
      !cz_top_omega
      !cz_top_omega_div_omega_crit
      
      !cz_top_zone
      !cz_top_zone_logdq
      
   ! mass fractions at top of largest convection zone (by mass)
      !cz_top_log_xa h1
      !cz_top_log_xa he4

   ! information about cores

      he_core_mass
      !he_core_radius
      !he_core_lgT
      !he_core_lgRho
      !he_core_L
      !he_core_v
      !he_core_omega
      !he_core_omega_div_omega_crit

      c_core_mass
      !c_core_radius
      !c_core_lgT
      !c_core_lgRho
      !c_core_L
      !c_core_v
      !c_core_omega
      !c_core_omega_div_omega_crit

      o_core_mass
      !o_core_radius
      !o_core_lgT
      !o_core_lgRho
      !o_core_L
      !o_core_v
      !o_core_omega
      !o_core_omega_div_omega_crit
   
      si_core_mass
      !si_core_radius
      !si_core_lgT
      !si_core_lgRho
      !si_core_L
      !si_core_v
      !si_core_omega
      !si_core_omega_div_omega_crit
   
      fe_core_mass
      !fe_core_radius
      !fe_core_lgT
      !fe_core_lgRho
      !fe_core_L
      !fe_core_v      
      !fe_core_omega
      !fe_core_omega_div_omega_crit
   
      neutron_rich_core_mass
      !neutron_rich_core_radius
      !neutron_rich_core_lgT
      !neutron_rich_core_lgRho
      !neutron_rich_core_L
      !neutron_rich_core_v      
      !neutron_rich_core_omega
      !neutron_rich_core_omega_div_omega_crit

      !envelope_mass ! = star_mass - he_core_mass
      !envelope_fraction_left ! = envelope_mass / (initial_mass - he_core_mass)

      !h_rich_layer_mass ! = star_mass - he_core_mass
      !he_rich_layer_mass ! = he_core_mass - c_core_mass
      !c_rich_layer_mass ! = c_core_mass - o_core_mass
      !o_rich_layer_mass ! = o_core_mass - si_core_mass
      !si_rich_layer_mass ! = si_core_mass - fe_core_mass
   
   

   ! info about locations where optical depth is 10 or 100

      !tau10_mass ! mass in solar units where optical depth = 10
      !tau10_radius ! radius in solar units where optical depth = 10
      !tau10_lgP ! estimate for log10(P) at tau = 10
      !tau10_T ! estimate for T at tau = 10
      !tau10_lgT ! estimate for log10(T) at tau = 10
      !tau10_lgRho ! estimate for log10(density) at tau = 10
      !tau10_L ! estimate for L/Lsun at tau = 10
      
      !tau100_mass ! location in solar units where optical depth = 100
      !tau100_radius ! location in solar units where optical depth = 100
      !tau100_lgP ! estimates for values at tau = 100
      !tau100_T
      !tau100_lgT
      !tau100_lgRho
      !tau100_L

   ! timescales
      
      !dynamic_timescale ! dynamic timescale (seconds) -- estimated by 2*pi*sqrt(r^3/(G*m))
      !kh_timescale ! kelvin-helmholtz timescale (years)
      !mdot_timescale ! star_mass/abs(star_mdot) (years)
      !kh_div_mdot_timescales ! kh_timescale/mdot_timescale
      !nuc_timescale ! nuclear timescale (years) -- proportional to mass divided by luminosity
      !log_chem_timescale ! burn+mix timescale (years)
         ! approximately min over all cells k and species i of x(i,k)/abs(dxdt_mix + dxdt_burn)
      !log_chem_timescale_div_time_step
      !log_cell_collapse_timescale

   ! integrated power
   
      !power_h_burn ! total thermal power from PP and CNO, excluding neutrinos (in Lsun units)
      !power_he_burn ! total thermal power from triple-alpha, excluding neutrinos (in Lsun units)
      !power_c_burn ! total thermal power from carbon burning, excluding neutrinos (in Lsun units)
      log_LH ! log10 power_h_burn
      log_LHe ! log10 power_he_burn
      !log_LC ! log10 power_c_burn
      log_LZ ! log10 total burning power including LC, but excluding LH and LHe and photodisintegrations
      log_Lnuc ! log(LH + LHe + LZ)
      !log_Lnuc_sub_log_L
      !extra_L ! integral of extra_heat in Lsun units
      !log_extra_L ! log10 extra_L
      !log_Lneu ! log10 power emitted in neutrinos, nuclear and thermal (in Lsun units)
      !log_Lneu_nuc ! log10 power emitted in neutrinos, nuclear sources only (in Lsun units)
      !log_Lneu_nonnuc ! log10 power emitted in neutrinos, thermal sources only (in Lsun units)
      !mass_loc_of_max_eps_nuc ! (in Msun units)
      !mass_ext_to_max_eps_nuc ! (in Msun units)
      !eps_grav_integral ! (in Lsun units)
      !log_abs_Lgrav ! log10 abs(eps_grav_integral) (in Lsun units)
      
      
   ! conditions at the photosphere
      log_Teff ! log10 effective temperature
      effective_T
      photosphere_L ! Lsun units
      photosphere_r ! Rsun units
      
   
   
   ! conditions at or near the surface of the model (outer edge of outer cell)
   
      luminosity ! luminosity in Lsun units
      log_L ! log10 luminosity in Lsun units
      log_R ! log10 radius in Rsun units
      radius ! Rsun
      radius_cm
      log_R_cm
      
      !log_g ! log10 gravity
      !gravity 
      !log_Ledd
      !log_L_div_Ledd ! log10(L/Leddington)
      !lum_div_Ledd
      !log_surf_opacity
      !log_surf_P
      !log_surf_pressure
      !log_surf_density
      !log_surf_temperature
      !surface_temperature
      !log_surf_optical_depth
      !surface_optical_depth
      !log_surf_z
      !surface_entropy ! in units of kerg per baryon
      
      !surf_avg_j_rot
      !surf_avg_omega
      !surf_avg_omega_crit
      !surf_avg_omega_div_omega_crit
      !surf_avg_v_rot ! km/sec rotational velocity at equator
      !surf_avg_v_crit ! critical rotational velocity at equator
      !surf_avg_v_div_v_crit
      !surf_avg_Lrad_div_Ledd
      !surf_avg_logT
      !surf_avg_logRho
      !surf_avg_opacity
      
      !surf_escape_v ! cm/s
      
      !v_wind_Km_per_s ! Km/s
         ! = 1d-5*s% opacity(1)*max(0d0,-s% mstar_dot)/ &
         !        (4*pi*s% photosphere_r*Rsun*s% tau_base)
         ! Lars says:
            ! wind_mdot = 4*pi*R^2*rho*v_wind
            ! tau = integral(opacity*rho*dr) from R to infinity
            ! so tau = opacity*wind_mdot/(4*pi*R*v_wind) at photosphere
            ! or v_wind = opacity*wind_mdot/(4*pi*R*tau) at photosphere
      
      !rotational_mdot_boost ! factor for increase in mass loss mdot due to rotation
      !log_rotational_mdot_boost ! log factor for increase in mass loss mdot due to rotation
      !surf_r_equatorial_div_r_polar
      !surf_r_equatorial_div_r
      !surf_r_polar_div_r
      
   
   ! conditions near center
   
      log_center_T ! temperature
      log_center_Rho ! density
      log_center_P ! pressure
      !center_T ! temperature
      !center_Rho ! density
      !center_P ! pressure
      
      !center_degeneracy ! the electron chemical potential in units of k*T
      !center_gamma ! plasma interaction parameter
      center_mu
      center_ye
      center_abar
      
      !center_eps_grav
      !center_non_nuc_neu
      !center_dL_dm
      !center_eps_nuc
      !d_center_eps_nuc_dlnT
      !d_center_eps_nuc_dlnd
      !log_center_eps_nuc
      
      !center_entropy ! in units of kerg per baryon
      !max_entropy ! in units of kerg per baryon
      !fe_core_infall
      !non_fe_core_infall
      
      !compactness_parameter ! (m/Msun)/(R(m)/1000km) for m = 2.5 Msun
      
      !center_omega
      !center_omega_div_omega_crit
      

   ! mass fractions near center
      
      center h1
      center he4
      center c12
      center o16
      ! etc. -- do as many of these 'center' commands as desired
      
   ! log10 central mass fractions
      
      !log_center h1
      !log_center he4
      ! etc.

      
   ! mass fractions near surface
   
      !surface h1
      !surface he4
      surface c12
      surface o16
      ! etc.
      
   ! log mass fractions near surface
   
      !log_surface h1
      !log_surface he4
      
   ! mass fractions for entire star
      
      !average h1
      !average he4
      ! etc.
      
   ! mass totals for entire star (in Msun units)
      
      total_mass h1
      total_mass he4
      ! etc.
      
   ! log10 mass totals for entire star (in Msun units)
      
      !log_total_mass h1
      !log_total_mass he4
      ! etc.
      
   ! log10 mass fractions for entire star
      
      !log_average h1
      !log_average he4
      ! etc.
      
   ! the following add all of the isos that are in the current net

   ! add_center_abundances
   ! add_surface_abundances
   ! add_average_abundances
   ! add_log_center_abundances
   ! add_log_surface_abundances
   ! add_log_average_abundances


   ! log10 total luminosity for reaction categories (Lsun units)
      
      pp
      cno
      tri_alfa
!      burn_c
!      burn_n
!      burn_o
!      burn_ne
!      burn_na
!      burn_mg
!      burn_si
!      burn_s
!      burn_ar
!      burn_ca
!      burn_ti
!      burn_cr
!      burn_fe
!      c12_c12
!      c12_o16
!      o16_o16
!      photo
!      pnhe4
!      other
      
      
   ! center log10 burn erg/g/s for reaction categories
   
      !c_log_eps_burn cno
      !c_log_eps_burn tri_alfa

   ! center d_eps_nuc_dlnd for reaction categories
   
      !c_d_eps_dlnd cno
      !c_d_eps_dlnd tri_alfa

   ! center d_eps_nuc_dlnT for reaction categories
   
      !c_d_eps_dlnT cno
      !c_d_eps_dlnT tri_alfa


   ! info about the max burning locations for hydrogen, helium, and metals
      
      ! info about location where have max rate of hydrogen burning (PP and CNO)
      !max_eps_h ! erg/g/s
      !max_eps_h_lgT ! log10 temperature at location of max burn
      !max_eps_h_lgRho ! log10 density at location of max burn
      !max_eps_h_m ! mass coordinate at location of max burn (Msun units)
      !max_eps_h_xm ! mass exterior to location of max burn (Msun units)
      !max_eps_h_lgP ! log10 pressure at location of max burn
      !max_eps_h_lgR ! log10 radius at location of max burn
      !max_eps_h_opacity ! opacity at location of max burn
      
      ! info about location where have max rate of helium burning
         ! triple-alpha plus alpha capture on C12, N14, O16, and Ne20.
      !max_eps_he ! erg/g/s
      !max_eps_he_lgT ! log10 temperature at location of max_eps_he
      !max_eps_he_lgRho ! log10 density at location of max burn
      !max_eps_he_m ! mass coordinate at location of max burn (Msun units)
      !max_eps_he_xm ! mass exterior to location of max burn (Msun units)
      !max_eps_he_lgP ! log10 pressure at location of max burn
      !max_eps_he_lgR ! log10 radius at location of max burn
      !max_eps_he_opacity ! opacity at location of max burn
      
      ! info about location where have max rate of burning of metals
         ! alpha capture on heavy elements plus C+C, C+O, O+O, etc.
      !max_eps_z ! erg/g/s
      !max_eps_z_lgT ! log10 temperature at location of max burn
      !max_eps_z_lgRho ! log10 density at location of max burn
      !max_eps_z_m ! mass coordinate at location of max burn (Msun units)      
      !max_eps_z_xm ! mass exterior to location of max burn (Msun units)
      !max_eps_z_lgP ! log10 pressure at location of max burn
      !max_eps_z_lgR ! log10 radius at location of max burn
      !max_eps_z_opacity ! opacity at location of max burn
      
      ! info about location where have max rate of burning of all types
      !max_eps_nuc ! erg/g/s
      !max_eps_nuc_lgT ! log10 temperature at location of max burn
      !max_eps_nuc_lgRho ! log10 density at location of max burn
      !max_eps_nuc_m ! mass coordinate at location of max burn (Msun units)      
      !max_eps_nuc_xm ! mass exterior to location of max burn (Msun units)
      !max_eps_nuc_lgP ! log10 pressure at location of max burn
      !max_eps_nuc_lgR ! log10 radius at location of max burn
      !max_eps_nuc_opacity ! opacity at location of max burn
      !max_eps_nuc_cp ! Cp at location of max burn
      !max_eps_nuc_t_heat ! Cp*T/eps_nuc at location of max burn
      !max_eps_nuc_csound
      !max_eps_nuc_pi_r_div_cs
      !max_eps_nuc_H ! pressure scale height
      !max_eps_nuc_H_div_cs
      !max_eps_nuc_log_xa he4 ! any species
   
   
   ! info at a specified mass coordinate (given by trace_mass_location)
      !trace_mass_location ! (Msun)
      !trace_mass_radius ! (Rsun)
      !trace_mass_lgT
      !trace_mass_lgRho
      !trace_mass_L ! (Lsun)
      !trace_mass_v

      !trace_mass_lgP
      !trace_mass_g
      !trace_mass_X
      !trace_mass_Y
      !trace_mass_edv_H
      !trace_mass_edv_He
      !trace_mass_scale_height
      !trace_mass_dlnX_dr
      !trace_mass_dlnY_dr
      !trace_mass_dlnRho_dr

      !trace_mass_omega
      !trace_mass_omega_div_omega_crit

   
   ! info at location of max temperature
      !max_T_lgT
      !max_T_mass ! (Msun)
      !max_T_radius ! (Rsun)
      !max_T_lgRho
      !max_T_lgP
      !max_T_entropy
      !max_T_L ! (Lsun)
      !max_T_eps_nuc ! (erg/g/s)
      !max_T_lgP_thin_shell ! log10(G*Mcore*Menv/(4*pi*Rcore^4))
         ! Mcore = Msun*max_T_mass,
         ! Menv = Msun*(star_mass - max_T_mass),
         ! Rcore = Rsun*max_T_radius
      !max_T_shell_binding_energy ! integral from max_T out

   
   ! info at location of max abs velocity
      ! note: can use control "min_tau_for_max_abs_v_location" to exclude surface
      !max_abs_v_velocity
      !max_abs_v_csound
      !max_abs_v_v_div_cs
      !max_abs_v_lgT
      !max_abs_v_lgRho
      !max_abs_v_lgP
      !max_abs_v_mass
      !max_abs_v_radius
      !max_abs_v_radius_cm
      !max_abs_v_lgR ! Rsun
      !max_abs_v_lgR_cm
      !max_abs_v_L ! Lsun
      !max_abs_v_entropy
      !max_abs_v_eps_nuc
      !max_abs_v_E0 ! 4/3 pi R^3 crad T^4 at max_abs_v_location
   
   
      ! info at innermost mach 1 location
      ! excluding locations with q < min_q_for_inner_mach1_location
      ! dr = r at mach 1 times shock_spread_quadratic parameter
      !inner_mach1_plus_dr_mass ! baryonic (Msun)
      !inner_mach1_plus_dr_radius ! (Rsun)
      !inner_mach1_plus_dr_velocity
      !inner_mach1_plus_dr_csound
      !inner_mach1_plus_dr_v_div_cs
      !inner_mach1_plus_dr_lgT
      !inner_mach1_plus_dr_lgRho
      !inner_mach1_plus_dr_lgP
      !inner_mach1_plus_dr_gamma1
      !inner_mach1_plus_dr_entropy
      !inner_mach1_plus_dr_k
      
      ! info at location of max entropy inward from inner mach 1 location
      ! excluding locations with q < min_q_for_inner_mach1_location
      ! dr = r at mach 1 times mach1_minus_dr_factor parameter
      !inner_mach1_minus_dr_mass ! baryonic (Msun)
      !inner_mach1_minus_dr_radius ! (Rsun)
      !inner_mach1_minus_dr_velocity
      !inner_mach1_minus_dr_csound
      !inner_mach1_minus_dr_v_div_cs
      !inner_mach1_minus_dr_lgT
      !inner_mach1_minus_dr_lgRho
      !inner_mach1_minus_dr_lgP
      !inner_mach1_minus_dr_gamma1
      !inner_mach1_minus_dr_entropy
      !inner_mach1_minus_dr_k
      
      ! info at outermost mach 1 location
      ! excluding locations with q > max_q_for_outer_mach1_location
      ! dr = r at mach 1 times mach1_plus_dr_factor parameter
      !outer_mach1_plus_dr_mass ! baryonic (Msun)
      !outer_mach1_plus_dr_radius ! (Rsun)
      !outer_mach1_plus_dr_velocity
      !outer_mach1_plus_dr_csound
      !outer_mach1_plus_dr_v_div_cs
      !outer_mach1_plus_dr_lgT
      !outer_mach1_plus_dr_lgRho
      !outer_mach1_plus_dr_lgP
      !outer_mach1_plus_dr_gamma1
      !outer_mach1_plus_dr_entropy
      !outer_mach1_plus_dr_k
      
      ! info at location of max entropy inward from outer mach 1 location
      ! excluding locations with q > max_q_for_outer_mach1_location
      ! dr = r at mach 1 times mach1_minus_dr_factor parameter
      !outer_mach1_minus_dr_mass ! baryonic (Msun)
      !outer_mach1_minus_dr_radius ! (Rsun)
      !outer_mach1_minus_dr_velocity
      !outer_mach1_minus_dr_csound
      !outer_mach1_minus_dr_v_div_cs
      !outer_mach1_minus_dr_lgT
      !outer_mach1_minus_dr_lgRho
      !outer_mach1_minus_dr_lgP
      !outer_mach1_minus_dr_gamma1
      !outer_mach1_minus_dr_entropy
      !outer_mach1_minus_dr_k
      
   
   ! asteroseismology
      !delta_nu ! large frequency separation for p-modes (microHz)
         ! 1e6/(seconds for sound to cross diameter of star)
      !delta_Pg ! g-mode period spacing for l=1 (seconds)
         ! sqrt(2) pi^2/(integral of brunt_N/r dr)
      !log_delta_Pg
      !nu_max ! estimate from scaling relation (microHz)
         ! nu_max = nu_max_sun * M/Msun / ((R/Rsun)^3 (Teff/Teff_sun)^0.5)
         ! with nu_max_sun = 3100 microHz, Teff_sun = 5777
      !nu_max_3_4th_div_delta_nu ! nu_max^0.75/delta_nu
      !acoustic_cutoff ! 0.5*g*sqrt(gamma1*rho/P) at surface
      !acoustic_radius ! integral of dr/csound (seconds)
      !ng_for_nu_max ! = 1 / (nu_max*delta_Pg)
         ! period for g-mode with frequency nu_max = nu_max_ng*delta_Pg
      !gs_per_delta_nu ! delta_nu / (nu_max**2*delta_Pg)
         ! number of g-modes per delta_nu at nu_max
      
      !int_k_r_dr_nu_max_SL ! integral of k_r*dr where nu < N < Sl for nu = nu_max, l=1
      !int_k_r_dr_2pt0_nu_max_SL ! integral of k_r*dr where nu < N < Sl for nu = nu_max*2, l=1
      !int_k_r_dr_0pt5_nu_max_SL ! integral of k_r*dr where nu < N < Sl for nu = nu_max/2, l=1
      !int_k_r_dr_nu_max_Sl2 ! integral of k_r*dr where nu < N < Sl for nu = nu_max, l=2
      !int_k_r_dr_2pt0_nu_max_Sl2 ! integral of k_r*dr where nu < N < Sl for nu = nu_max*2, l=2
      !int_k_r_dr_0pt5_nu_max_Sl2 ! integral of k_r*dr where nu < N < Sl for nu = nu_max/2, l=2
      !int_k_r_dr_nu_max_Sl3 ! integral of k_r*dr where nu < N < Sl for nu = nu_max, l=3
      !int_k_r_dr_2pt0_nu_max_Sl3 ! integral of k_r*dr where nu < N < Sl for nu = nu_max*2, l=3
      !int_k_r_dr_0pt5_nu_max_Sl3 ! integral of k_r*dr where nu < N < Sl for nu = nu_max/2, l=3
      
      ! energy information
      
         !total_internal_energy_start
         !total_internal_energy
         !total_internal_energy_change

         !total_gravitational_energy_start
         !total_gravitational_energy
         !total_gravitational_energy_change

         !total_linear_kinetic_energy_start
         !total_linear_kinetic_energy
         !total_linear_kinetic_energy_change

         !total_rotational_kinetic_energy_start
         !total_rotational_kinetic_energy
         !total_rotational_kinetic_energy_change

         !total_energy_start
         !total_energy
         !total_energy_change

         !total_IE_plus_KE_start
         !total_IE_plus_KE
         !total_IE_plus_KE_change
         
         !total_eps_grav
         !total_visc_heat_added
         !cumulative_visc_heat_added
         !acoustic_L
         !cumulative_acoustic_L
         !acoustic_L_center
         !cumulative_acoustic_L_center
         !total_nuclear_heating
         !total_non_nuc_neu_cooling
         !total_irradiation_heating
         !total_extra_heating
         !total_energy_sources_and_sinks
         
         !cumulative_extra_heating
         !cumulative_irradiation_heating
         !cumulative_nuclear_heating
         !cumulative_non_nuc_neu_cooling
         
         
         
         !error_in_energy_conservation
         !rel_error_in_energy_conservation
         !total_energy_and_integrated_fluxes ! total_energy + cumulative_sources_and_sinks
         !cumulative_energy_error ! should be same as total_energy_and_integrated_fluxes
         
         !cumulative_sources_and_sinks
         !log_rel_cumulative_energy_error
         
         !log_max_v_residual
         !log_max_lnd_residual
         !log_max_lnE_residual
         !log_max_lnR_residual
         
         !log_mesh_adjust_IE_conservation ! total internal energy
         !log_mesh_adjust_PE_conservation ! total gravitational potential energy
         !log_mesh_adjust_KE_conservation ! total (linear) kinetic energy
      
   ! misc

      !v_surf ! (cm/s)
      !v_surf_km_s ! (km/s)
      v_div_csound_surf ! velocity divided by sound speed at outermost grid point
      !v_surf_div_v_kh ! v_surf/(photosphere_r/kh_timescale)
      !surface_accel_div_grav ! (v - v_old)/dt divided by GM/R^2 at outermost grid point
      
      !e_thermal ! sum over all zones of Cp*T*dm
      
      num_retries ! total during the run
      num_backups ! total during the run
      !total_num_newton_iterations ! during the run
      !num_newton_iterations ! per step
      !num_newton_iters_stage1 ! per step
      !num_newton_iters_stage2 ! per step
      !num_newton_iters_stage3 ! per step
      !num_newton_iters_stage4 ! per step
      !num_newton_iters_stage5 ! per step
      !num_newton_iters_stage6 ! per step
      !num_newton_iters_stage7 ! per step
      !num_newton_iters_stage8 ! per step
      !ebdf_order
      !truncation_ratio
      !eps_nuc_dot_dm_average
      !non_nuc_neu_dot_dm_average
      !irradiation_heat_dot_dm_average
      !extra_heat_dot_dm_average
      !eps_grav_dot_dm_average
      !eps_visc_dot_dm_average
      !acoustic_L_average
      !surface_L_average
      
      !max_conv_vel_div_csound
      !max_gradT_div_grada
      !max_gradT_sub_grada
      !min_log_mlt_Gamma
      
      
      !dt_cell_collapse ! min time for any cell to collapse at current velocities
      !dt_div_dt_cell_collapse

      
      !dt_Courant ! min dr_div_csound (sec) -- min cell sound crossing time
      !log_dt_Courant ! log10 min dr_div_csound (sec)
      !dt_Courant_yr ! min dr_div_csound (years)
      !log_dt_Courant_yr ! log10 min dr_div_csound (years)
      !dt_div_dt_Courant
      !log_dt_div_dt_Courant
      
      !h1_czb_mass ! location (in Msun units) of base of 1st convection zone above he core 
      
      !surf_c12_minus_o16 ! this is useful for seeing effects of dredge up on AGB
      
      !elapsed_time ! time since start of run (seconds)
      
      !min_t_eddy ! minimum value of scale_height/conv_velocity
      
      !min_Pgas_div_P
      !starting_q_min_Pgas_div_P
            
      !rotation_solver_steps
      
      !diffusion_solver_steps
      !diffusion_solver_iters
      
      !version_number ! mesa version from file mesa/data/version_number
            
      !gradT_excess_alpha
      !gradT_excess_min_beta
      !gradT_excess_max_lambda 
            
            
      !k_below_Eulerian_eps_grav
      !q_below_Eulerian_eps_grav
      !logxq_below_Eulerian_eps_grav
            
      !k_Lagrangian_eps_grav
      !q_Lagrangian_eps_grav
      !logxq_Lagrangian_eps_grav
            
      !k_below_const_q
      !q_below_const_q
      !logxq_below_const_q
      
      !k_const_mass 
      !q_const_mass 
      !logxq_const_mass 
      
      !k_below_just_added 
      !q_below_just_added 
      !logxq_below_just_added 
            
      !k_for_CpTMdot_div_L_limit
      !q_for_CpTMdot_div_L_limit
      !logxq_for_CpTMdot_div_L_limit
            
      !k_CpTMdot_lt_L
      !q_CpTMdot_lt_L
      !logxq_CpTMdot_lt_L
      
      !surface_extra_Pgas


      !log_max_T ! temperature
      !max_T

      
      
      
