module Paths_blog (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/n/code/hakyll-bio/.stack-work/install/x86_64-linux-ncurses6/lts-6.6/7.10.3/bin"
libdir     = "/home/n/code/hakyll-bio/.stack-work/install/x86_64-linux-ncurses6/lts-6.6/7.10.3/lib/x86_64-linux-ghc-7.10.3/blog-0.1.0.0-7BxnRWobmWLBdDwWj0i1gF"
datadir    = "/home/n/code/hakyll-bio/.stack-work/install/x86_64-linux-ncurses6/lts-6.6/7.10.3/share/x86_64-linux-ghc-7.10.3/blog-0.1.0.0"
libexecdir = "/home/n/code/hakyll-bio/.stack-work/install/x86_64-linux-ncurses6/lts-6.6/7.10.3/libexec"
sysconfdir = "/home/n/code/hakyll-bio/.stack-work/install/x86_64-linux-ncurses6/lts-6.6/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "blog_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "blog_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "blog_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "blog_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "blog_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
