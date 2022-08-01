cfg = [];
cfg.dataset = 'clean.set';
data = ft_preprocessing(cfg);
elec = data.elec;

cfg = [];
cfg.covariance = 'yes';
tlckFC = ft_timelockanalysis(cfg, data);

cfg           = [];
cfg.method    = 'interactive';
cfg.elec      = elec;
cfg.headshape = headmodel.bnd(1);
elec  = ft_electroderealign(cfg);  %interactive elec registration
tlckFC.elec = elec;


cfg = [];
cfg.sourcemodel = sourcemodel;
cfg.headmodel   = headmodel;
cfg.elec        = elec;

leadfield = ft_prepare_leadfield(cfg);

cfg               = [];
cfg.method        = 'eloreta';
cfg.sourcemodel   = leadfield;
cfg.headmodel     = headmodel;
cfg.eloreta.lambda = 0.05;
cfg.eloreta.keepmom = 'yes';
cfg.mne.keepmom = 'yes';
cfg.eloreta.keepfilter = 'yes';
sourceEEG = ft_sourceanalysis(cfg,tlckFC);

figure(1);
m=sourceEEG.avg.pow(:,1); 
ft_plot_mesh(sourceEEG, 'vertexcolor', m);
view([180 0]); h = light; set(h, 'position', [0 1 0.2]); lighting gouraud; material dull

