Pod::Spec.new do |s|
    s.name         = 'FJTagCollectionView'
    s.version      = '0.0.1'
    s.summary      = '一个生产自定义TagView的容器，可以用于帖子的相关标签，搜索热词显示等等'
    s.homepage     = 'https://github.com/jeffnjut/FJTagCollectionView'
    s.license      = 'MIT'
    s.authors      = {'jeff_njut' => 'jeff_njut@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/jeffnjut/FJTagCollectionView.git', :tag => s.version}
    s.source_files = 'FJTagCollectionView/**/*.{h,m}'
    s.resources    = "FJTagCollectionView/**/*.{xib,png}"
    s.requires_arc = true
    s.dependency   'JSONModel'
end
